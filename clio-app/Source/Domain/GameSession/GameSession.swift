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
    
    func addPlayerInSession(name: String, image: String) {
        if gameFlowParameters.players.count > 4 {
            alertError = AlertError(
                showAlert: true,
                errorMessage: "Já foi atingido o máximo de jogadores"
            )
            return
        }
        
        let newUser = User(id: UUID(), name: name, picture: image)
        gameFlowParameters.players.append(newUser)
    }
    
    func randomizeThemes() {
        gameFlowParameters.sessionTheme = "Historia"
    }
}

struct GameFlowParameters {
    var players: [User] = []
    var didPlay: [User] = []
    var sessionTheme: String = String()
}

struct AlertError {
    var showAlert = false
    var errorMessage = ""
}
