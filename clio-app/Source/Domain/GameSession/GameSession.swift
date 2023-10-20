//
//  GameSession.swift
//  clio-app
//
//  Created by Thiago Henrique on 17/10/23.
//

import Foundation
import ClioEntities

final class GameSession: ObservableObject {
    enum GameState: Equatable {
        case start
        case midle
        case final
    }
    
    @Published var gameState: GameState = .start
    
    // MARK: Change game state logic
    func changeGameState(to newState: GameState) {
        DispatchQueue.main.async {
            self.gameState = newState
        }
    }
    
    @Published var gameFlowParameters = GameFlowParameters()
    @Published var alertError = AlertError()
    @Published var themeManager = ThemeManager()

    /// Move to another file if necessary
    let profilePictures: [String] = ["profile-picture-eye", "bonfire-picture", "circles-picture"]
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

        let newUser = User(id: UUID(), name: name, picture: image)
        gameFlowParameters.players.append(newUser)
    }

    func removePlayerInSession(_ player: User) {
        if let index = gameFlowParameters.players.firstIndex(of: player) {
            gameFlowParameters.players.remove(at: index)
        }
    }

    func randomizeProfileImage() -> String {
        return profilePictures.randomElement()!.description
    }

    func canStartGame() -> Bool {
        return gameFlowParameters.players.count < minimumPlayers
    }

    func hasReachedPlayerLimit() -> Bool {
        return gameFlowParameters.players.count > 4
    }
    
    func getCurrentTheme() -> String {
        if let description = gameFlowParameters.currenPlayer?.artefact?.description {
            return description
        }
        return gameFlowParameters.sessionTheme
    }

    // MARK: - Raffle Theme Functions
    func randomizeThemes() {
        gameFlowParameters.sessionTheme = themeManager.themes.randomElement()!
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
    }
    
    private func addPlayerToDidPlay() {
        guard let player = gameFlowParameters.currenPlayer else { return }
        gameFlowParameters.didPlay.append(player)
        if gameFlowParameters.didPlay.count == (gameFlowParameters.players.count - 1) {
            changeGameState(to: .final)
        }
    }
    
    // MARK: Artifacts Functions
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
    var themes: [String] = ["Historia","Geografia", "Filosofia","Biologia"]
}
