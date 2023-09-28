//
//  LobbyPlayerContainer.swift
//  clio-app
//
//  Created by Luciana Adrião on 22/09/23.
//

import SwiftUI

struct PlayersContainer: View {
    @Binding var lobbyID: UUID
    let columnCount: Int = 3
    let gridVSpacing: CGFloat = 12.0
    let gridHSpacing: CGFloat = 20.0

    // Sample data for players (get from model)
    let players: [Player] = [
        .init(name: "Name 1"),
        .init(name: "Name 2"),
        .init(name: "Name 3"),
        .init(name: "Name 4"),
        .init(name: "Name 5"),
        .init(name: "Name 6"),
        .init(name: "Name 7")
    ]

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
            ForEach(players, id: \.id) { player in
                PlayerGridItem(player: .constant(player))
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



// MARK: - *temporary* player model
struct Player: Identifiable {
    let id = UUID()
    let name: String
    let playerScore: Int = 0
}

#Preview(body: {
    PlayersContainer(lobbyID: .constant(UUID()))
})
