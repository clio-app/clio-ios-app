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
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                
                UserTextConfirmation(name: vm.currentPlayer?.name ?? "")
                    .foregroundColor(.black)
                
                Spacer()
                
            }
            .safeAreaInset(edge: .bottom) {
                ButtonsToConfirmation(
                    confirmationAction: {
                        if let player = vm.currentPlayer {
                            gameSession.addPlayerInRound(player: player)

                            switch gameSession.gameState {
                            case .start:
                                router.goToPhotoArtifactView()
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
            .navigationBarBackButtonHidden()
        }
        .applyHelpButton(.SelectPlayer)
        .clioBackground()
        .onAppear {
            let player = gameSession.getRandomPlayer()
            vm.changePlayer(newPlayer: player)
        }
    }
}


#Preview {
    SelectPlayerView()
}
