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
                            masterUser: master.user.picture,
                            sendImageTapped: { image, description in
                                Task {
                                    vm.connectInRoom(roomCode)
                                    await vm.sendMasterArtefacts(
                                        picture: image,
                                        description: description
                                    )
                                }
                            }
                        )
                    } else {
                        Text("Aguardando mestre")
                            .bold()
                        .navigationBarBackButtonHidden()
                    }
                case .describingImage(let image):
                    DescribingImageView(imageData: image)
                case .waitingAwnsers:
                    Text("Aguardando respostas")
                    .bold()
                case .voting(descriptions: let descriptions):
                    VotingView(descriptions: descriptions)
                case .gameEnd(users: let users):
                   GameEndView(users: users)
            }
        }
        .onAppear {
            vm.client.clientOutput = vm
            vm.isHost = host
        }
        .environmentObject(vm)
    }
}
