//
//  LobbyScreenView.swift
//  clio-app
//
//  Created by Luciana Adrião on 22/09/23.
//

import SwiftUI

struct LobbyView: View {
    @StateObject private var model = LobbyViewModel()



    var body: some View {
        GeometryReader { geo in
            VStack {
                LobbyHeader(lobbyName: .constant("Turma A"), 
                            lobbyTheme: .constant("1ª Guerra Mundial"),
                            lobbyPasscode: .constant("XSJAMP"))

                MasterContainer(username: .constant("Prof. Juliano"), userscore: .constant(163)).lineLimit(1)
                    .frame(width: geo.size.width * 0.6, height: geo.size.height * 0.2)

                activePlayersText

                PlayersContainer(lobbyID: .constant(UUID()))

                // TODO: Opacity controlled by players status -> empty or not
                ActionButton(title: "Iniciar partida", foregroundColor: .blue, hasBorder: false) {
                    // Button action
                    Task {
                        await model.fetchRoom()
                    }
                }
                .frame(height: geo.size.height * 0.08)

            }
            .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.9)
            .frame(width: geo.size.width, height: geo.size.height)
            .background(Color.offWhite)
        }
        .foregroundColor(.black)
        .ignoresSafeArea()
    }
}

#Preview {
    LobbyView()
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
