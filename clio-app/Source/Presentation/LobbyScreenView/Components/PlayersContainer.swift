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
//        .init(name: "Name 1"),
//        .init(name: "Name 2"),
//        .init(name: "Name 3"),
//        .init(name: "Name 4")
    ]

    // TODO: Array of player that are NOT the master
    var body: some View {
        GeometryReader { geo in
            VStack {
                ScrollView(.vertical) {
                    activePlayersText

                    if players.isEmpty { emptyLobby } else { playerGridView.padding(.horizontal, 8.0) }

                }

                Spacer()
            }
            .frame(width: geo.size.width * 0.84)
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
            }
            .scaledToFill()
        }
    }

    // MARK: - empty Lobby
    private var emptyLobby: some View {
        VStack(alignment: .center, spacing: 12.0) {
            Text("Sem jogadores ativos ainda.").padding(.bottom, 24.0)
            Text("Convide seus alunos pelo código:")
            Text("\(lobbyID)")
        }
        .font(.itimRegular(fontType: .body))
    }
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


    // MARK: - Action Button

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
