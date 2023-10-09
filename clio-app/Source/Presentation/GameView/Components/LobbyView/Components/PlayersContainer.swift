//
//  LobbyPlayerContainer.swift
//  clio-app
//
//  Created by Luciana Adrião on 22/09/23.
//

import SwiftUI
import ClioEntities

struct PlayersContainer: View {
    let lobbyID: String
    let columnCount: Int = 3
    let gridVSpacing: CGFloat = 12.0
    let gridHSpacing: CGFloat = 20.0

    // Sample data for players (get from model)
    @State var players: [RoomUser] = []

    // TODO: Array of player that are NOT the master
    var body: some View {
        GeometryReader { geo in
            VStack {
                ScrollView(.vertical) {
                    if players.isEmpty {
                        emptyLobby
                    } else {
                        playerGridView.padding(.horizontal, 8.0)
                    }
                }
                .scrollIndicators(.hidden)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}


// MARK: - Lobby Subcomponents
extension PlayersContainer {

    // MARK: - Grid View
    private var playerGridView: some View {
        LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: gridHSpacing), count: columnCount), spacing: gridVSpacing) {
            ForEach(players, id: \.user.id) { player in
                PlayerGridItem(
                    player: player
                )
                    .offset(y: 1.0)
            }
            .scaledToFill()
        }
    }

    // MARK: - empty Lobby
    private var emptyLobby: some View {
        VStack(alignment: .center, spacing: 12.0) {
            Text("Sem jogadores ativos ainda.")
                .padding(.bottom, 24.0)
            Text("Convide seus alunos pelo código:")
            Text("\(lobbyID)")
        }
        .multilineTextAlignment(.center)
        .font(.itimRegular(fontType: .body))
    }
}

#Preview(body: {
    PlayersContainer(lobbyID: "ABC123")
})
