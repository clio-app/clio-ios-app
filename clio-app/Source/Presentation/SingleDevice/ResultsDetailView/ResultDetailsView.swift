//
//  ResultDetailsView.swift
//  clio-app
//
//  Created by Thiago Henrique on 18/10/23.
//

import SwiftUI
import ClioEntities

struct ResultDetailsView: View {
    @EnvironmentObject var gameSession: GameSession
    @EnvironmentObject var router: Router
    @State var showedPlayers: [User] = []
    @State var currentInteraction = 0
    @State var startInteractions = false
    @State var endInteractions = false
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ThemeBubble(theme: gameSession.gameFlowParameters.sessionTheme)
                .frame(
                    width: geo.size.width * 0.8,
                    height: geo.size.height * 0.2
                )
                
                VStack(spacing: 1){
                    Text("A frase era...")
                        .font(.itimRegular(fontType: .title3))
                        .foregroundStyle(.black)
                        .padding([.top])
                    
                    Text(gameSession.gameFlowParameters.firstRoundPrompt)
                        .font(.itimRegular(fontType: .title3))
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(16)
                        .foregroundStyle(.black)
                        .overlay {
                            RoundedRectangle(
                                cornerRadius: 16
                            )
                            .stroke(.black, lineWidth: 1)
                        }
                        .background(Color.white)
                }
                .padding([.horizontal, .vertical])
                
                if startInteractions {
                    ScrollView {
                        ForEach((0..<showedPlayers.count), id: \.self) { index in
                            HStack(alignment: .bottom, spacing: 12) {
                                UserAvatar(
                                    userName: showedPlayers[index].name,
                                    picture: showedPlayers[index].picture
                                )
                                
                                ArtefactView(
                                    artefact: showedPlayers[index].artefact!
                                )
                                .padding([.bottom], 16)
                                
                                Spacer()
                            }
                            .padding([.horizontal], 26)
                            .padding([.vertical], 32)
                            .animation(.easeIn, value: index)
                        }
                    }
                    .scrollIndicators(.visible)
                    .padding([.vertical], 6)
                }
                
                if endInteractions {
                    ActionButton(
                        title: "Jogar Novamente",
                        foregroundColor: .blue,
                        backgroundColor: .white,
                        hasBorder: true
                    ) {
                        gameSession.restartGame()
                        router.clear()
                    }
                    .frame(height: 42)
                    .padding([.horizontal], 32)
                } else {
                    Image(systemName: "chevron.down.circle.fill")
                        .resizable()
                        .frame(width: 46, height: 46)
                        .foregroundStyle(.black, Color.customYellow)
                        .overlay {
                            Circle()
                                .stroke(lineWidth: 3.0)
                                .foregroundColor(.black)
                        }
                        .onTapGesture {
                            addPlayerInteraction()
                        }
                }
                
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .clioBackground()
        }
        .navigationBarBackButtonHidden()
        .applyHelpButton(.presentResult)
    }
    
    func addPlayerInteraction() {
        showedPlayers = []
        let playersCount = gameSession.gameFlowParameters.didPlay.count - 1
        if currentInteraction == 0 { withAnimation { startInteractions = true } }
        if currentInteraction > playersCount {
            endInteractions = true
            showedPlayers = gameSession.gameFlowParameters.didPlay
            return
        }
        
        withAnimation(.linear) {
            showedPlayers.append(
                gameSession.gameFlowParameters.didPlay[currentInteraction]
            )
            
            currentInteraction += 1
        }
    }
}

#Preview {
    @ObservedObject var gameSession = GameSession()
    @ObservedObject var router = Router()
    gameSession.addPlayerInSession(
        name: "name01",
        image: "profile-picture-eye"
    )
    gameSession.addPlayerInSession(
        name: "name02",
        image: "bonfire-picture"
    )
    gameSession.addPlayerInSession(
        name: "name03",
        image: "profile-picture-eye"
    )
    gameSession.randomizeThemes()
    gameSession.selectFirstRoundPrompt()
    let user1 = gameSession.gameFlowParameters.players[0]
    let user2 = gameSession.gameFlowParameters.players[1]
    
    gameSession.gameFlowParameters.didPlay.append(
        User(
            id: user1.id,
            name: user1.name,
            picture: user1.picture,
            artefacts: SessionArtefacts(
                picture: UIImage(named: "AppIcon")!.pngData()!,
                description: "Funny description",
                masterId: user1.id
            )
        )
    )
    
    gameSession.gameFlowParameters.didPlay.append(
        User(
            id: user2.id,
            name: user2.name,
            picture: user2.picture,
            artefacts: SessionArtefacts(
                picture: Data(),
                description: "Funny description",
                masterId: user2.id
            )
        )
    )
    
    
    let resultView = ResultDetailsView()
        .environmentObject(gameSession)
        .environmentObject(router)
    
    return resultView
}

