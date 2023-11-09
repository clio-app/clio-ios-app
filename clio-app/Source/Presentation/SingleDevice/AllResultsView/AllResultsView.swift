//
//  SwiftUIView.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 07/11/23.
//

import SwiftUI
import ClioEntities

struct AllResultsView: View {
    @EnvironmentObject var gameSession: GameSession
    @EnvironmentObject var router: Router
    
    @State var showZoomImage: Bool = false
    @State var selectedImage: Data?

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack (spacing: geo.size.height * 0.11) {
                    DescriptionCard(description: gameSession.gameFlowParameters.firstRoundPrompt)
                    ForEach(0..<gameSession.gameFlowParameters.didPlay.count, id: \.self) { index in
                        VStack(spacing: 24) {
                            UserAvatar(
                                userName: gameSession.gameFlowParameters.didPlay[index].name,
                                picture: gameSession.gameFlowParameters.didPlay[index].picture
                            )
                            if let imageData = gameSession.gameFlowParameters.didPlay[index].artefact?.picture {
                                ImageCard(imageData: imageData) 
                                    .onTapGesture {
                                        showZoomImage = true
                                        selectedImage = imageData
                                    }
                                    .frame(
                                        width: geo.size.width * 0.8,
                                        height: geo.size.width * 0.8
                                    )
                            }
                            if let description = gameSession.gameFlowParameters.didPlay[index].artefact?.description {
                                DescriptionCard(description: description)
                                    .padding(.horizontal, 2)
                            }
                        }
                    }
                }
                .frame(width: geo.size.width * 0.8)
            }
            .frame(width: geo.size.width)
            .padding(.bottom,  geo.size.height * 0.025)
            .scrollIndicators(.hidden)
            .clipped()
            .overlay {
                if showZoomImage {
                    ZoomImage(
                        selectedImage: $showZoomImage,
                        uiImage: .init(data: selectedImage!)!
                    )
                    .ignoresSafeArea()
                }
            }
            .safeAreaInset(edge: .bottom) {
                VStack {
                    ActionButton(
                        title: "Jogar Novamente",
                        foregroundColor: .lapisLazuli,
                        backgroundColor: .offWhite,
                        hasBorder: true) {
                            gameSession.restartGame()
                            router.restartGameWithPlayers()
                        }
                        .frame(width: geo.size.width * 0.8, height: 50)
                        .padding(.bottom)
                        .disabled(showZoomImage)
                        .opacity(showZoomImage ? 0.3 : 1)
                    ActionButton(
                        title: "Sair",
                        foregroundColor: .sky,
                        backgroundColor: .offWhite,
                        hasBorder: true) {
                            gameSession.fullResetGame()
                            router.clear()
                        }
                        .frame(width: geo.size.width * 0.8, height: 50)
                        .disabled(showZoomImage)
                        .opacity(showZoomImage ? 0.3 : 1)
                }
                .padding(.bottom)
            }
        }
        .navigationBarBackButtonHidden()
        .clioBackground()
        .applyHelpButton(.AllResultsVisualization)
    }
}

#Preview {
    @ObservedObject var gameSession = GameSession()
    @ObservedObject var router = Router()
    gameSession.addPlayerInSession(
        name: "name01",
        image: "Lilac"
    )
    gameSession.addPlayerInSession(
        name: "name02",
        image: "Lilac"
    )
    gameSession.addPlayerInSession(
        name: "name03",
        image: "Lilac"
    )
    gameSession.randomizeThemes()
    gameSession.selectFirstRoundPrompt()
    let user1 = gameSession.gameFlowParameters.players[0]
    let user2 = gameSession.gameFlowParameters.players[1]
    let user3 = gameSession.gameFlowParameters.players[2]

    gameSession.gameFlowParameters.didPlay.append(
        User(
            id: user2.id,
            name: user2.name,
            picture: user2.picture,
            artefacts: SessionArtefacts(
                picture: UIImage(named: "liquid-bg")!.pngData()!,
                description: nil,
                masterId: user2.id
            )
        )
    )

    gameSession.gameFlowParameters.didPlay.append(
        User(
            id: user1.id,
            name: user1.name,
            picture: user1.picture,
            artefacts: SessionArtefacts(
                picture: UIImage(named: "AppIcon")!.pngData()!,
                description: "Funny description dvjsdfbvajkvadkjvbadjhbvadf kaidbvkjhad f majhsvdchabd v mdjbadf v jadcjhbad kjbsdjvbsdjhvs SkdjbvhJSd SDjbvJHSDv kbsdhjvbzdjhv",
                masterId: user1.id
            )
        )
    )
    
    gameSession.gameFlowParameters.didPlay.append(
        User(
            id: user3.id,
            name: user3.name,
            picture: user3.picture,
            artefacts: SessionArtefacts(
                picture: nil,
                description: "Funny description",
                masterId: user1.id
            )
        )
    )
    
    let view = AllResultsView()
        .environmentObject(gameSession)
        .environmentObject(router)
    
    return view
}
