//
//  ResultsView.swift
//  clio-app
//
//  Created by Thiago Henrique on 18/10/23.
//

import SwiftUI

struct ResultsView: View {
    @EnvironmentObject var gameSession: GameSession
    @EnvironmentObject var router: Router
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text(gameSession.gameFlowParameters.sessionTheme)
                    .font(.largeTitle)
                    .foregroundStyle(.black)
                    .padding([.top], geo.size.height * 0.1)
                
                Spacer()
                
                VStack {
                    Text("Reuna seus amigos")
                        .foregroundStyle(.black)
                    
                    HStack(spacing: -10) {
                        ForEach(gameSession.gameFlowParameters.players, id: \.id) { player in
                                Circle()
                                    .frame(width: 50, height: 50)
                                    .foregroundStyle(.black)
                                    .overlay {
                                        Image(player.picture)
                                            .resizable()
                                            .scaledToFit()
                                    }
                        }
                    }
                }
                
                Spacer()
                
                VStack {
                    Text("Clique aqui para ver as respostas")
                        .foregroundStyle(.black)
                    
                    NavigationLink {
                        ResultDetailsView()
                    } label: {
                        Circle()
                            .frame(width: 46, height: 46)
                            .foregroundStyle(.gray)
                            .overlay {
                                Image("check_icon")
                                    .resizable()
                                    .scaledToFill()
                            }
                    }
                }
                .padding([.bottom], geo.size.height * 0.2)
            }
            .frame(
                width: geo.size.width,
                height: geo.size.height
            )
        }
        .background{Color.white.ignoresSafeArea()}
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    @ObservedObject var gameSession = GameSession()
    @ObservedObject var router = Router()
    gameSession.addPlayerInSession(name: "name01", image: "")
    gameSession.addPlayerInSession(name: "name02", image: "")
    gameSession.addPlayerInSession(name: "name03", image: "")
    gameSession.randomizeThemes()
    
    let resultView = ResultsView()
        .environmentObject(gameSession)
        .environmentObject(router)
    
    return resultView
}
