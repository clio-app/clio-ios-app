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
    @State var withImage: Bool = false
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
                        if !withImage {
                            CameraView(
                                vm: CameraViewModel(roomTheme: vm.roomTheme),
                                navigateToNextView: $withImage
                            )
                            .navigationBarBackButtonHidden()
                        } else {
                            MasterInputView(
                                userEntryText: "",
                                userList: users.compactMap { $0.user.picture },
                                masterUser: master.user.picture,
                                roomName: $vm.roomName,
                                roomTheme: $vm.roomTheme,
                                sendImageTapped: { description in
                                    Task {
                                        vm.connectInRoom(roomCode)
                                        await vm.sendMasterArtefacts(
                                            picture: vm.imageData,
                                            description: description
                                        )
                                    }
                                }
                            )
                        }
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
