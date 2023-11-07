//
//  ResultDetailsView.swift
//  clio-app
//
//  Created by Thiago Henrique on 18/10/23.
//

import SwiftUI
import ClioEntities

struct ResultPerPlayerView: View {
    @EnvironmentObject var gameSession: GameSession
    @EnvironmentObject var router: Router
    @ObservedObject var vm: ResultsDetailViewModel = ResultsDetailViewModel()
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                switch vm.state {
                case .showTheme:
                    VStack {
                        ThemeBubble(theme: gameSession.gameFlowParameters.sessionTheme)
                            .frame(
                                height: geo.size.height * 0.2
                            )
                    }
                    .frame(width: geo.size.width)
                    .transition(.move(edge: .leading))
                default:
                    TabView(selection: $vm.currentInteraction, content: {
                        ForEach(0..<gameSession.gameFlowParameters.didPlay.count, id: \.self) { index in
                            VStack (spacing: 20) {
                                Spacer()
                                if vm.state == .presentFirstArtifact {
                                    DescriptionCard(description: gameSession.gameFlowParameters.firstRoundPrompt)
                                        .onTapGesture {
                                            vm.showZoomDescription = true
                                        }
                                }
                                UserAvatar(
                                    userName: gameSession.gameFlowParameters.didPlay[index].name,
                                    picture: gameSession.gameFlowParameters.didPlay[index].picture
                                )
                                ArtefactView(
                                    artefact: gameSession.gameFlowParameters.didPlay[index].artefact!,
                                    showZoomImage: $vm.showZoomImage,
                                    showZoomDescription: $vm.showZoomDescription
                                )
                                .transition(.opacity)
                                Spacer()
                                if vm.state != .presentLastArtifact {
                                    hintText
                                    Spacer()
                                }
                            }
                            .frame(width: geo.size.width * 0.8)
                            .padding(.bottom)
                        }
                    })
                    .tabViewStyle(.page(indexDisplayMode: .automatic))
                    .onAppear {
                        setupAppearance()
                    }
                    .transition(.move(edge: .trailing))
                }
            }
            .safeAreaInset(edge: .bottom) {
                if vm.state == .presentLastArtifact {
                    ActionButton(
                        title: "Ver tudo",
                        foregroundColor: .lapisLazuli,
                        backgroundColor: .offWhite,
                        hasBorder: true) {
                            router.goToAllResultsVisualizationView()
                        }
                        .frame(width: geo.size.width * 0.8, height: 60)
                        .transition(.scale.combined(with: .opacity))
                        .padding(.bottom)
                    
                }
            }
            .onChange(of: vm.currentInteraction) { newValue in
                let newState = vm.checkNextState(newValue, gameSession.gameFlowParameters.didPlay.count-1)
                withAnimation {
                    vm.changeState(newState: newState)
                }
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            .overlay {
                if vm.showZoomImage {
                    ZoomImage(
                        selectedImage: $vm.showZoomImage,
                        uiImage: UIImage(data: gameSession.gameFlowParameters.didPlay[vm.currentInteraction].artefact!.picture!)!
                    )
                } else if vm.showZoomDescription {
                    ZoomDescriptionCard(
                        showZoomDescription: $vm.showZoomDescription,
                        description: vm.currentInteraction == 0 ? gameSession.gameFlowParameters.firstRoundPrompt : gameSession.gameFlowParameters.didPlay[vm.currentInteraction].artefact!.description!
                    )
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        vm.changeState(newState: .presentFirstArtifact)
                    }
                }
            }
            .clioBackground()
        }
        .navigationBarBackButtonHidden()
        .applyHelpButton(.ResultsPerPlayerVisualization)
    }
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .lapisLazuli
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
      }
}

extension ResultPerPlayerView {
    var hintText: some View {
        Text("Arraste para o lado para ver outras respostas")
            .foregroundColor(.black)
            .font(.itimRegular(size: 15))
            .multilineTextAlignment(.center)
            .transition(.scale)
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


    let resultView = ResultPerPlayerView()
        .environmentObject(gameSession)
        .environmentObject(router)

    return resultView
}

