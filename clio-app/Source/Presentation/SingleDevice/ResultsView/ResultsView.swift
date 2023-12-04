//
//  ResultsView.swift
//  clio-app
//
//  Created by Thiago Henrique on 18/10/23.
//

import SwiftUI
import ClioDomain

struct ResultsView: View {
    @EnvironmentObject var gameSession: GameSession
    @EnvironmentObject var router: Router
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 55) {
                Spacer()
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
                
                Text("É hora de reunir seus amigos e compartilhar respostas!")
                    .foregroundColor(.black)
                    .font(.itimRegular(fontType: .title3))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 28)
                    .padding(.vertical, 8)
                    .background {
                        BorderedBackground(foregroundColor: .offWhite, hasBorder: false)
                    }
                    .padding(.horizontal, 30)
                
                Spacer()
                
                ActionButton(
                    title: "Ver respostas",
                    foregroundColor: .lapisLazuli,
                    backgroundColor: .offWhite,
                    hasBorder: true
                ) {
                    AudioManager.shared.playSound(named: .seeAnswersButton)
                    router.goToAllResultsVisualizationView()
                }
                .frame(height: 60)
                .padding(30)
            }
            .frame(
                width: geo.size.width,
                height: geo.size.height,
                alignment: .center
            )
        }
        .clioBackground()
        .navigationBarBackButtonHidden()
        .applyHelpButton(.PresentResults)
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

