//
//  SelectPlayerView.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 19/10/23.
//

import SwiftUI

struct SelectPlayerView: View {
    @StateObject var vm: SelectPlayerViewModel = SelectPlayerViewModel()
    
    @EnvironmentObject var gameSession: GameSession
    @EnvironmentObject var router: Router
    
    @State private var showPopup = false
    @State private var goToTakePictureView = false
    @State private var goToPickImageView = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack {
                    Spacer()
                    
                    UserTextConfirmation(name: vm.currentPlayer?.name ?? "")
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    ButtonsToConfirmation(
                        confirmationAction: {
                            if let player = vm.currentPlayer {
                                gameSession.addPlayerInRound(player: player)
                                
                                switch gameSession.gameState {
                                    case .start:
                                        showPopup = true
    //                                    router.goToPhotoArtifactView()
                                    default:
                                        router.goToDescriptionArtifactView()
                                }
                            }
                        },
                        negationAction: {
                            vm.changeViewState(to: .findingPlayer)
                            let player = gameSession.getRandomPlayer(currentPlayer: vm.currentPlayer)
                            vm.changePlayer(newPlayer: player)
                        },
                        isLastUser: gameSession.gameState == .final
                    )
                    .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.18)
                    .padding(.bottom, geo.size.height * 0.05)
                }
                .overlay {
                    if vm.viewState == .findingPlayer {
                        LoadingPlayer()
                            .frame(width: geo.size.width, height: geo.size.height)
                    }
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .popupNavigationView(show: $showPopup) {
                    TakePictureModePopup(
                        inputPhrase: gameSession.gameFlowParameters.firstRoundPrompt,
                        takePictureButtonTapped: { goToTakePictureView = true },
                        pickImageButtonTapped: { goToPickImageView = true },
                        isShowing: $showPopup
                    )
                    .frame(width: geo.size.width, height: geo.size.height)
                }
                .navigationDestination(isPresented: $goToTakePictureView) {
                    PhotoArtifactView()
                }
                .navigationDestination(isPresented: $goToPickImageView) {
                    PickImageView()
                }
                .clioBackground()
                .applyHelpButton(.SelectPlayer)
                .navigationBarBackButtonHidden()
            }
        }
        .onAppear {
            let player = gameSession.getRandomPlayer()
            vm.changePlayer(newPlayer: player)
        }
    }
}


#Preview {
    let gameSession = GameSession()
    
    gameSession.addPlayerInSession(name: "Thiago", image: "")
    gameSession.addPlayerInSession(name: "Araujo", image: "")
    gameSession.addPlayerInSession(name: "Batista", image: "")
    
    gameSession.randomizeThemes()
    gameSession.gameFlowParameters.firstRoundPrompt = "Floresta Amazônica: Os Pulmões da Terra."
    
    return SelectPlayerView()
        .environmentObject(gameSession)
        .environmentObject(Router())
}
