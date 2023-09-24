//
//  LobbyScreenView.swift
//  clio-app
//
//  Created by Luciana Adrião on 22/09/23.
//

import SwiftUI

struct LobbyScreenView: View {
    var body: some View {
        GeometryReader { geo in
            VStack {

                // TODO: Add header (lobby name, lobby theme and lobby passcode)

                MasterContainer(username: .constant("Prof. Juliano"), userscore: .constant(163)).lineLimit(1)
                    .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.2)

                PlayersContainer(lobbyID: .constant(UUID()))

                // TODO: Opacity controlled by players status -> empty or not
                ActionButton(title: "Iniciar partida", foregroundColor: .blue, hasBorder: false) {
                    // Button action
                }
                .frame(width:geo.size.width * 0.9, height: geo.size.height * 0.1)

            }
            .frame(width: geo.size.width, height: geo.size.height * 0.9)
            .frame(width: geo.size.width, height: geo.size.height)
            .background(Color.offWhite)
        }
    }
}

#Preview {
    LobbyScreenView()
}
