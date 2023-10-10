//
//  GameView.swift
//  clio-app
//
//  Created by Thiago Henrique on 09/10/23.
//

import SwiftUI

struct GameView: View {
    @StateObject private var vm = GameViewModel()
    @State var host: Bool
    var roomCode: String
    
    var body: some View {
        ZStack {
            switch vm.gameState {
                case .registerUser:
                    AnonymousLoginView(roomCode: roomCode)
                case .waitingUsers:
                    LobbyView(roomCode: roomCode)
                case .takingArtefacts(let master, let users):
                    if host {
                        MasterInputView(
                            userEntryText: "",
                            userList: users.compactMap { $0.user.picture },
                            masterUser: master.user.picture
                        )
                    } else {
                        Text("Aguardando mestre")
                    }
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
