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
    
    func addPlayerInSession(name: String, image: String) {
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
