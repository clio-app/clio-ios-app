////
////  GameSession.swift
////  clio-app
////
////  Created by Thiago Henrique on 17/10/23.
////
//
//import Foundation
//import ClioEntities
//import Mixpanel
//
//final class GameSession: ObservableObject {
//    enum GameState: Equatable {
//        case start
//        case midle
//        case final
//    }
//
//    @Published var gameState: GameState = .start
//    @Published var gameFlowParameters = GameFlowParameters()
//    @Published var alertError = AlertError()
//    @Published var themeManager = ThemeManager()
//    @Published var profileImageManager = ProfileImageManager()
//    private var startPlayerRoundTime: DispatchTime!
//
//    /// Move to another file if necessary
//    var minimumPlayers: Int = 3
//
//
//    // MARK: - PlayersView Functions
//    func addPlayerInSession(name: String, image: String) {
//        if gameFlowParameters.players.count > 4 {
//            alertError = AlertError(
//                showAlert: true,
//                errorMessage: NSLocalizedString("Já foi atingido o máximo de jogadores", comment: "max players reached")
//            )
//            return
//        }
//        if name.isEmpty || name.hasPrefix(" ") {
//            alertError = AlertError(showAlert: true, errorMessage: NSLocalizedString("Opa! O nome do jogador não pode estar vazio.", comment: "name is blank"))
//            alertError = AlertError(showAlert: true, errorMessage: NSLocalizedString("Opa! O nome do jogador não pode estar vazio.", comment: "name is blank"))
//            return
//        }
//
//        let newUser = User(id: UUID(), name: name, picture: image, artefacts: nil)
//        gameFlowParameters.players.append(newUser)
//    }
//
//    func removePlayerInSession(_ player: User) {
//        if let index = gameFlowParameters.players.firstIndex(of: player) {
//            gameFlowParameters.players.remove(at: index)
//        }
//    }
//
//    func canStartGame() -> Bool {
//        return gameFlowParameters.players.count < minimumPlayers
//    }
//
//    func hasReachedPlayerLimit() -> Bool {
//        return gameFlowParameters.players.count > 4
//    }
//
//    // MARK: - Raffle Theme Functions
//    func randomizeThemes() {
//        gameFlowParameters.sessionTheme = themeManager.themes.randomElement()!
//    }
//
//
//    func selectFirstRoundPrompt() {
//        // Parse the JSON data into a Swift dictionary
//        if let firstPrompt = themeManager.themePhrases[gameFlowParameters.sessionTheme]?.randomElement() {
//            gameFlowParameters.firstRoundPrompt = firstPrompt
//        }
//    }
//
//    // MARK: Change game state logic
//    func changeGameState(to newState: GameState) {
//        DispatchQueue.main.async {
//            self.gameState = newState
//        }
//    }
//    
//    func restartGame() {
//        gameFlowParameters.didPlay = []
//        gameFlowParameters.emojisIndexReaction = []
//        changeGameState(to: .start)
//    }
//    
//    func fullResetGame() {
//        gameFlowParameters.didPlay = []
//        gameFlowParameters.players = []
//        gameFlowParameters.emojisIndexReaction = []
//        gameFlowParameters.currenPlayer = nil
//        changeGameState(to: .start)
//    }
//    
//    // MARK: - Select Player Functions
//    func getRandomPlayer(currentPlayer: User? = nil) -> User? {
//        let filteredList = gameFlowParameters.players.filter({ player in
//            !gameFlowParameters.didPlay.contains(where: {$0.id == player.id})
//        })
//        if let currentUser = currentPlayer {
//            if let newUser = filteredList.filter({ $0 != currentUser}).randomElement() {
//                return newUser
//            }
//        }
//        let newUser = filteredList.randomElement()
//        return newUser
//
//    }
//
//    func addPlayerInRound(player: User) {
//        gameFlowParameters.currenPlayer = player
//        startPlayerRoundTime = .now()
//    }
//    
//    private func addPlayerToDidPlay() {
//        guard let player = gameFlowParameters.currenPlayer else { return }
//        let endPlayerRoundTime: DispatchTime = .now()
//        let roundElapsedTime = Double(endPlayerRoundTime.uptimeNanoseconds - startPlayerRoundTime.uptimeNanoseconds) / 1_000_000_000
//        
//        Mixpanel.mainInstance().track(
//            event: "Player Round Time",
//            properties: [
//                "Seconds": roundElapsedTime,
//                "isFirstPlayer": gameFlowParameters.didPlay.isEmpty
//            ]
//        )
//        
//        gameFlowParameters.didPlay.append(player)
//        if gameFlowParameters.didPlay.count == (gameFlowParameters.players.count - 1) {
//            changeGameState(to: .final)
//        }
//    }
//    
//    // MARK: Artifacts Functions
//    func getCurrentTheme() -> String {
//        if let description = gameFlowParameters.currenPlayer?.artefact?.description {
//            return description
//        }
//        return gameFlowParameters.firstRoundPrompt
//    }
//    
//    func sendArtifact(picture: Data? = nil, description: String? = nil, reactionEmojiIndex: Int? = nil) {
//        if let pictureArtifact = picture {
//            sendPhoto(imageData: pictureArtifact)
//        }
//        if let descriptionArtifact = description {
//            sendDescription(description: descriptionArtifact)
//        }
//        if let emojiIndex = reactionEmojiIndex {
//            sendEmojiIndex(emojiIndex: emojiIndex)
//        }
//    }
//    
//    private func sendPhoto(imageData data: Data) {
//        guard (gameFlowParameters.currenPlayer != nil) else { return }
//        switch gameState {
//        case .start:
//            gameFlowParameters.currenPlayer!.artefact = .init(
//                masterId: gameFlowParameters.currenPlayer!.id,
//                picture: data,
//                description: nil
//            )
//            changeGameState(to: .midle)
//        case .midle:
//            gameFlowParameters.currenPlayer!.artefact?.picture = data
//        case .final:
//            return
//        }
//        addPlayerToDidPlay()
//    }
//    
//    private func sendDescription(description: String) {
//        if let currenPlayer = gameFlowParameters.currenPlayer {
//            gameFlowParameters.currenPlayer?.artefact = .init(masterId: currenPlayer.id)
//            gameFlowParameters.currenPlayer?.artefact?.description = description
//        }
//        if gameState == .final {
//            addPlayerToDidPlay()
//        }
//    }
//    
//    private func sendEmojiIndex(emojiIndex: Int) {
//        gameFlowParameters.emojisIndexReaction.append(emojiIndex)
//    }
//    
//    func getEmojiName(index: Int) -> String? {
//        let emojiIndex = gameFlowParameters.emojisIndexReaction[index]
//        if emojiIndex != 0 {
//            return "Emoji\(emojiIndex)"
//        }
//        return nil
//    }
//    
//    func getLastImage() -> Data? {
//        if gameFlowParameters.didPlay.count > 0 {
//            let lastIndex = gameFlowParameters.didPlay.count - 1
//            let lastUser = gameFlowParameters.didPlay[lastIndex]
//            return lastUser.artefact?.picture
//        }
//        return nil
//    }
//}
//
//struct GameFlowParameters {
//    var currenPlayer: User?
//    var players: [User] = []
//    var didPlay: [User] = []
//    var sessionTheme: String = String()
//    var firstRoundPrompt: String = String()
//    var emojisIndexReaction: [Int] = []
//}
//
//struct AlertError {
//    var showAlert = false
//    var errorMessage = ""
//}
//
//struct ThemeManager {
//    var themes: [String] = []
//    var themePhrases: [String: [String]] = [:]
//
//    init() {
//        readJSONFile(withName: "ThemePhrases")
//    }
//
//    mutating func readJSONFile(withName name: String) {
//        do {
//            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"), let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
//                    if let localizedData = try?  JSONSerialization.jsonObject(with: jsonData) as? [String:[String]] {
//                        themes = Array(localizedData.keys)
//                        themePhrases = localizedData
//                    } else {
//                        /// Temporary check up
//                        assertionFailure("Check the JSON file for the localized version for language \(Locale.current.identifier).")
//                    }
//            }
//        } catch {
//            themePhrases = ["Test":["No themes available"]]
//            print(error)
//        }
//    }
//}
//
//struct ProfileImageManager {
//    var profileColors: [String] = ["Brick", "Lilac", "Peach", "SoftGreen", "Sky"]
//    var currentIndex: Int = .random(in: 0..<4)
//
//    mutating func randomizeProfileImage() -> String {
//        let color = profileColors[currentIndex]
//        currentIndex = (currentIndex + 1) % profileColors.count // Wrap around to the beginning if needed
//        return color
//    }
//}
