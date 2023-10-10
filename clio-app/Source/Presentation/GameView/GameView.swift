//
//  GameView.swift
//  clio-app
//
//  Created by Thiago Henrique on 09/10/23.
//

import SwiftUI

struct GameView: View {
    @StateObject private var vm = GameViewModel()
    var roomCode: String
    
    var body: some View {
        ZStack {
            switch vm.gameState {
                case .registerUser:
                    AnonymousLoginView(roomCode: roomCode)
                case .waitingUsers:
                    LobbyView(roomCode: roomCode)
                case .gameStarting:
                    EmptyView()
                case .takingArtefacts:
                    EmptyView()
                case .describingImage:
                    EmptyView()
                case .waitingAwnsers:
                    EmptyView()
            }
        }
        .onAppear {
            vm.client.clientOutput = vm
        }
        .environmentObject(vm)
    }
}
