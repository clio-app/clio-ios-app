//
//  GameSession.swift
//  clio-app
//
//  Created by Thiago Henrique on 17/10/23.
//

import Foundation
import ClioEntities
import Mixpanel

final class GameSession: ObservableObject {
    enum GameState: Equatable {
        case start
        case midle
        case final
    }
    
    @Published var gameState: GameState = .start
    @Published var gameFlowParameters = GameFlowParameters()
    @Published var alertError = AlertError()
    @Published var themeManager = ThemeManager()
    @Published var profileImageManager = ProfileImageManager()
    private var startPlayerRoundTime: DispatchTime!

    /// Move to another file if necessary
    var minimumPlayers: Int = 3


    // MARK: - PlayersView Functions
    func addPlayerInSession(name: String, image: String) {
        if gameFlowParameters.players.count > 4 {
            alertError = AlertError(
                showAlert: true,
                errorMessage: "Já foi atingido o máximo de jogadores"
            )
            return
        }
        if name.isEmpty {
            alertError = AlertError(showAlert: true, errorMessage: "Opa! O nome do jogador não pode estar vazio.")
            return
        }

        let newUser = User(id: UUID(), name: name, picture: image, artefacts: nil)
        gameFlowParameters.players.append(newUser)
    }

    func removePlayerInSession(_ player: User) {
        if let index = gameFlowParameters.players.firstIndex(of: player) {
            gameFlowParameters.players.remove(at: index)
        }
    }

    func canStartGame() -> Bool {
        return gameFlowParameters.players.count < minimumPlayers
    }

    func hasReachedPlayerLimit() -> Bool {
        return gameFlowParameters.players.count > 4
    }

    // MARK: - Raffle Theme Functions
    func randomizeThemes() {
        gameFlowParameters.sessionTheme = themeManager.themes.randomElement()!
    }


    func selectFirstRoundPrompt() {
        // Parse the JSON data into a Swift dictionary
        if let data = themeManager.themePhrases.data(using: .utf8) {
            do {
                if let themes = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [String]] {
                    // Access the phrases using the themes dictionary
                    if let phrase = themes[gameFlowParameters.sessionTheme]?.randomElement() {
                        gameFlowParameters.firstRoundPrompt = phrase
                    }
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
    }

    // MARK: Change game state logic
    func changeGameState(to newState: GameState) {
        DispatchQueue.main.async {
            self.gameState = newState
        }
    }
    
    func restartGame() {
        gameFlowParameters.didPlay = []
        changeGameState(to: .start)
    }
    
    // MARK: - Select Player Functions
    func getRandomPlayer(currentPlayer: User? = nil) -> User? {
        let filteredList = gameFlowParameters.players.filter({ player in
            !gameFlowParameters.didPlay.contains(where: {$0.id == player.id})
        })
        if let currentUser = currentPlayer {
            if let newUser = filteredList.filter({ $0 != currentUser}).randomElement() {
                return newUser
            }
        }
        let newUser = filteredList.randomElement()
        return newUser

    }

    func addPlayerInRound(player: User) {
        gameFlowParameters.currenPlayer = player
        startPlayerRoundTime = .now()
    }
    
    private func addPlayerToDidPlay() {
        guard let player = gameFlowParameters.currenPlayer else { return }
        let endPlayerRoundTime: DispatchTime = .now()
        let roundElapsedTime = Double(endPlayerRoundTime.uptimeNanoseconds - startPlayerRoundTime.uptimeNanoseconds) / 1_000_000_000
        
        Mixpanel.mainInstance().track(
            event: "Player Round Time",
            properties: [
                "Seconds": roundElapsedTime,
                "isFirstPlayer": gameFlowParameters.didPlay.isEmpty
            ]
        )
        
        gameFlowParameters.didPlay.append(player)
        if gameFlowParameters.didPlay.count == (gameFlowParameters.players.count - 1) {
            changeGameState(to: .final)
        }
    }
    
    // MARK: Artifacts Functions
    func getCurrentTheme() -> String {
        if let description = gameFlowParameters.currenPlayer?.artefact?.description {
            return description
        }
        return gameFlowParameters.firstRoundPrompt
    }
    
    
    func sendArtifact(picture: Data? = nil, description: String? = nil) {
        if let pictureArtifact = picture {
            sendPhoto(imageData: pictureArtifact)
        }
        if let descriptionArtifact = description {
            sendDescription(description: descriptionArtifact)
        }
    }
    
    private func sendPhoto(imageData data: Data) {
        guard (gameFlowParameters.currenPlayer != nil) else { return }
        switch gameState {
        case .start:
            gameFlowParameters.currenPlayer!.artefact = .init(picture: data , masterId: gameFlowParameters.currenPlayer!.id)
            changeGameState(to: .midle)
        case .midle:
            gameFlowParameters.currenPlayer!.artefact?.picture = data
        case .final:
            return
        }
        addPlayerToDidPlay()
    }
    
    private func sendDescription(description: String) {
        if let currenPlayer = gameFlowParameters.currenPlayer {
            gameFlowParameters.currenPlayer?.artefact = .init(masterId: currenPlayer.id)
            gameFlowParameters.currenPlayer?.artefact?.description = description
        }
        if gameState == .final {
            addPlayerToDidPlay()
        }
    }
    
    func getLastImage() -> Data? {
        if gameFlowParameters.didPlay.count > 0 {
            let lastIndex = gameFlowParameters.didPlay.count - 1
            let lastUser = gameFlowParameters.didPlay[lastIndex]
            return lastUser.artefact?.picture
        }
        return nil
    }
}

struct GameFlowParameters {
    var currenPlayer: User?
    var players: [User] = []
    var didPlay: [User] = []
    var sessionTheme: String = String()
    var firstRoundPrompt: String = String()
}

struct AlertError {
    var showAlert = false
    var errorMessage = ""
}

struct ThemeManager {
    var themes: [String]
    let themePhrases = """
    {
      "Historia": [
        "1492: Colombo navegou e a América foi descoberta!",
        "Década de 1960: Amor livre, música animada e uma caminhada na lua.",
        "Guerra Fria: EUA vs. URSS, mísseis em vez de piscadas.",
        "Revolução Francesa: Adeus à monarquia, olá à liberdade!"
      ],
      "Geografia": [
        "Monte Everest: O desafio supremo da Terra para alpinistas.",
        "Floresta Amazônica: Os pulmões da Terra, o local favorito da vida selvagem.",
        "Deserto do Saara: A caixa de areia colossal da natureza.",
        "Grande Barreira de Coral: O paraíso submarino de Nemo.",
        "Cataratas do Niágara: O espetáculo de águas da natureza."
      ],
      "Filosofia": [
        "DNA: O código cósmico de 'você'.",
        "Mitocôndrias: A central de energia das células - onde a verdadeira energia acontece!",
        "Evolução: A jornada da vida de 'sob o mar' para 'fora do mar'.",
        "Sistema imunológico: O esquadrão de super-heróis do seu corpo na luta contra germes.",
        "Fotossíntese: Plantas transformando a luz solar em comida."
      ],
      "Biologia": [
          "A seleção natural: Natureza sendo a 'grande diretora de elenco' da vida na Terra.",
          "A diversidade da vida: Uma enorme coleção de organismos, cada um com seu próprio papel na história da vida.",
          "Genética e hereditariedade: O livro de receitas da vida, passado de geração em geração.",
          "Ecossistemas: A dança interconectada da vida, onde todos têm um papel a desempenhar.",
          "Adaptação: A habilidade dos seres vivos de jogar o jogo da sobrevivência e vencer."
      ]
    }
    """
    
    init() {
        if let data = themePhrases.data(using: .utf8) {
            do {
                if let themesDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [String]] {
                    themes = Array(themesDictionary.keys)
                } else {
                    themes = []
                }
            } catch {
                themes = []
                print("Error parsing JSON: \(error)")
            }
        } else {
            themes = []
        }
    }
}

struct ProfileImageManager {
    var profileColors: [String] = ["Brick", "Lilac", "Peach", "SoftGreen", "Sky"]
    var currentIndex: Int = 0

    mutating func randomizeProfileImage() -> String {
        let color = profileColors[currentIndex]
        currentIndex = (currentIndex + 1) % profileColors.count // Wrap around to the beginning if needed
        return color
    }
}
