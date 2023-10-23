//
//  ResultDetailsView.swift
//  clio-app
//
//  Created by Thiago Henrique on 18/10/23.
//

import SwiftUI

struct ResultDetailsView: View {
    @EnvironmentObject var gameSession: GameSession
    
    var body: some View {
        VStack {
            Text(gameSession.gameFlowParameters.sessionTheme)
                .font(.largeTitle)
            
            Spacer()
            
            VStack {
                ForEach((0..<gameSession.gameFlowParameters.players.count)) { index in
                    HStack {
                        if !index.isMultiple(of: 2) { Spacer() }
                        UserAvatar(
                            userName: gameSession.gameFlowParameters.players[index].name
                        )
                        if index.isMultiple(of: 2) { Spacer() }
                    }
                    .padding([.horizontal], 26)
                }
            }
            
        }
        .frame(height: 520)

    }
}

#Preview {
    @ObservedObject var gameSession = GameSession()
    gameSession.addPlayerInSession(name: "name01", image: "")
    gameSession.addPlayerInSession(name: "name02", image: "")
    gameSession.addPlayerInSession(name: "name03", image: "")
    gameSession.randomizeThemes()
    
    let resultView = ResultDetailsView()
        .environmentObject(gameSession)
    
    return resultView
}
