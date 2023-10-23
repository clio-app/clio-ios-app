//
//  ResultsView.swift
//  clio-app
//
//  Created by Thiago Henrique on 18/10/23.
//

import SwiftUI

struct ResultsView: View {
    @EnvironmentObject var gameSession: GameSession
    
    var body: some View {
        VStack {
            Text(gameSession.gameFlowParameters.sessionTheme)
                .font(.largeTitle)
            
            Spacer()
            
            VStack {
                Text("Reuna seus amigos")
                
                HStack(spacing: -10) {
                    ForEach(gameSession.gameFlowParameters.players, id: \.id) { player in
                            Circle()
                                .frame(width: 50, height: 50)
                    }
                }
            }
                        
            Spacer()
            
            Text("Clique aqui para ver as respostas")
            
            NavigationLink {
                ResultDetailsView()
            } label: {
                Circle()
                    .frame(width: 46, height: 46)
                    .foregroundStyle(.gray)
                    .overlay {
                        Image(systemName: "checkmark")
                            .foregroundStyle(.white)
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
    
    let resultView = ResultsView()
        .environmentObject(gameSession)
    
    return resultView
}
