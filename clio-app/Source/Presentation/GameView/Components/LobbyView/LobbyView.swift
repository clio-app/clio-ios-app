//
//  LobbyScreenView.swift
//  clio-app
//
//  Created by Luciana Adrião on 22/09/23.
//

import SwiftUI

struct LobbyView: View {
    @EnvironmentObject private var gameViewModel: GameViewModel
    @StateObject private var vm = LobbyViewModel()
    var roomCode: String

    var body: some View {
        GeometryReader { geo in
            VStack {
                LobbyHeader(lobbyName: .constant(vm.currentRoom?.room.name ?? "NAME_NOT_FOUND"),
                            lobbyTheme: .constant(vm.currentRoom?.room.theme.title ?? "THEME_NOT_FOUND"),
                            lobbyPasscode: .constant(vm.currentRoom?.room.id ?? "ID_NOT_FOUND"))

                MasterContainer(master: $gameViewModel.master)
                    .frame(width: geo.size.width * 0.6, height: geo.size.height * 0.2)

                activePlayersText

                PlayersContainer(lobbyID: roomCode, players: $gameViewModel.players)

                // TODO: Opacity controlled by players status -> empty or not
                ActionButton(title: "Iniciar partida", foregroundColor: .blue, hasBorder: false) {
                    if gameViewModel.players.count > 2 {
                        Task {
                            await gameViewModel.startGame()
                        }
                    }
                }
                .opacity(gameViewModel.players.count > 2 ? 1 : 0.2)
                .frame(height: geo.size.height * 0.08)

            }
            .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.9)
            .frame(width: geo.size.width, height: geo.size.height)
            .background(Color.offWhite)
        }
        .foregroundColor(.black)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        .onAppear {
            // TODO: This part will be done by the createRoom when a room is created the roomID should be parsed to findRoom(id) to update the lobby view
            Task {
                await vm.findRoom(id: roomCode)
            }
        }
    }
}

#Preview {
    LobbyView(roomCode: "A12312")
        .environmentObject(GameViewModel())
}

extension LobbyView {
    // MARK: - Active Players Label
    private var activePlayersText: some View {
        StrokeText(
            text: "Jogadores ativos",
            borderWidth: 2,
            borderColor: .black
        )
        .foregroundColor(.white)
        .font(.itimRegular(fontType: .title3))

    }
}
