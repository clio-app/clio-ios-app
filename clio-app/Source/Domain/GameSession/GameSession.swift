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

    func randomizeThemes() {
        gameFlowParameters.sessionTheme = "Historia"
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
        if !gameFlowParameters.photos.contains(photo) {
            gameFlowParameters.photos.append(photo)
            return
        }
    }
    
    func getCurrentTheme() -> String {
        return gameFlowParameters.sessionTheme
    }
}

struct GameFlowParameters {
    var players: [User] = []
    var didPlay: [User] = []
    
    // TODO: Refator for add photo in User
    var sessionTheme: String = "Historia"
    var photos: [Data] = []
}

struct AlertError {
    var showAlert = false
    var errorMessage = ""
}
