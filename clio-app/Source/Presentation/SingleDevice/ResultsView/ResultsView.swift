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

                // TODO: Virou componente dentro de resultsDetailView
                ThemeBubble(theme: gameSession.gameFlowParameters.sessionTheme)
                .padding([.top], geo.size.height * 0.1)

                Spacer()
                
                VStack {
                    Text("Junte seus amigos")
                        .foregroundStyle(.black)
                        .font(.itimRegular(fontType: .title2))

                    HStack(spacing: -10) {
                        ForEach(gameSession.gameFlowParameters.players, id: \.id) { player in
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                    .frame(width: 50, height: 50)
                                    .overlay {
                                        Circle()
                                            .stroke(lineWidth: 3.0)
                                            .foregroundColor(.black)
                                    }
                                    .applyColor(player.picture)
                        }
                    }
                }
                
                Spacer()

                VStack {
                    Text("Clique aqui para ver as respostas")
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.center)
                        .font(.itimRegular(fontType: .title3))

                    Button {
                        router.goToResultVisualization()
                    } label: {
                        Image(systemName: "chevron.down.circle.fill")
                            .resizable()
                            .frame(width: 46, height: 46)
                            .foregroundStyle(.black, Color.softGreen)
                            .overlay {
                                Circle()
                                    .stroke(lineWidth: 3.0)
                                    .foregroundColor(.black)
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
        .clioBackground()
        .navigationBarBackButtonHidden()
        .applyHelpButton(.readyForResults)
    }
}

#Preview {
    @ObservedObject var gameSession = GameSession()
    @ObservedObject var router = Router()
    gameSession.addPlayerInSession(name: "name01", image: "Brick")
    gameSession.addPlayerInSession(name: "name02", image: "Sky")
    gameSession.addPlayerInSession(name: "name03", image: "LapisLazuli")
    gameSession.randomizeThemes()
    
    let resultView = ResultsView()
        .environmentObject(gameSession)
        .environmentObject(router)
    
    return resultView
}
