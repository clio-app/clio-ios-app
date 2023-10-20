//
//  GameSession.swift
//  clio-app
//
//  Created by Thiago Henrique on 17/10/23.
//

import Foundation
import ClioEntities

final class GameSession: ObservableObject {
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
    
    // TODO: Refator for add photo in User
    func sendPhoto(data photo: Data) {
//        if !gameFlowParameters.photos.contains(photo) {
//            gameFlowParameters.photos.append(photo)
//            return
//        }
    }
    
    func getCurrentTheme() -> String {
        return gameFlowParameters.sessionTheme
    }

    // MARK: - Raffle Theme Functions
    func randomizeThemes() {
        gameFlowParameters.sessionTheme = themeManager.themes.randomElement()!
    }
    
    // MARK: - Select Player Functions
    func getRandomPlayer(currentPlayer: User? = nil) -> User? {
        let filteredList = gameFlowParameters.players.filter({ !gameFlowParameters.didPlay.contains($0) })
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
        gameFlowParameters.didPlay.append(player)
    }
    
    // MARK: Artifacts Functions
    func sendDescription(description: String) {
        if let currenPlayer = gameFlowParameters.currenPlayer {
            gameFlowParameters.currenPlayer?.artefact = .init(masterId: currenPlayer.id)
            gameFlowParameters.currenPlayer?.artefact?.description = description
        }
    }
    
    func getLastImage() -> Data? {
        guard let lastPlayer = gameFlowParameters.didPlay.last else { return nil }
        return lastPlayer.artefact?.picture
        
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
