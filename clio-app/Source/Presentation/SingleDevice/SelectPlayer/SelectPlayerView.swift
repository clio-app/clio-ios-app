//
//  SelectPlayerView.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 19/10/23.
//

import SwiftUI

struct SelectPlayerView: View {
    @StateObject var vm: SelectPlayerViewModel = SelectPlayerViewModel()
    
    @EnvironmentObject var session: GameSession
    
    @State var navigateToNextView = false
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                
                textConfirmation
                .foregroundColor(.black)
                
                Spacer()
                
                buttons
                .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.18)
                .padding(.bottom, geo.size.height * 0.05)
            }
            .overlay {
                if vm.viewState == .findingPlayer {
                    loading
                    .frame(width: geo.size.width, height: geo.size.height)
                }
            }
            .navigationDestination(isPresented: $navigateToNextView, destination: {
                ForEach(session.gameFlowParameters.didPlay, id: \.id) { player in
                    Text(player.name)
                }
            })
            .toolbar(.hidden, for: .navigationBar)
            .frame(width: geo.size.width, height: geo.size.height)
            .background{Color.white.ignoresSafeArea()}
        }
        .onAppear {
            let player = session.getRandomPlayer()
            vm.changePlayer(newPlayer: player)
        }
    }
}

extension SelectPlayerView {
    var textConfirmation: some View {
        VStack {
            Text("Você é...")
                .font(.itimRegular(fontType: .title3))

            Text(vm.currentPlayer?.name ?? "")
                .font(.itimRegular(fontType: .largeTitle))
        }
    }
    
    var buttons: some View {
        VStack {
            ActionButton(
                title: "Sim",
                foregroundColor: .softGreen,
                backgroundColor: .white,
                hasBorder: true) {
                    if let player = vm.currentPlayer {
                        session.addPlayerInRound(player: player)
                        navigateToNextView.toggle()
                    }
                }
            ActionButton(
                title: "Não",
                foregroundColor: .sky,
                backgroundColor: .white,
                hasBorder: true) {
                    vm.changeViewState(to: .findingPlayer)
                    let player = session.getRandomPlayer(currentPlayer: vm.currentPlayer)
                    vm.changePlayer(newPlayer: player)
                }
        }
    }
    
    var loading: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                ProgressView()
                    .tint(Color.lapisLazuli)
                Text("Buscando jogador...")
                    .foregroundColor(.lapisLazuli)
                    .font(.itimRegular(fontType: .headline))
            }
        }
    }
}

#Preview {
    SelectPlayerView()
}
