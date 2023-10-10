//
//  PlayerGridItem.swift
//  clio-app
//
//  Created by Luciana Adrião on 23/09/23.
//

import SwiftUI
import ClioEntities

struct PlayerGridItem: View {
    @State var player: RoomUser

    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center) {
                Image(player.user.picture)
                    .resizable()
                    .scaledToFit()
                    .offset(y: geo.size.height * 0.05)
                    .frame(maxHeight: geo.size.height * 0.3)
                Group {
                    Text("\(player.user.name)")
                    Text("\(player.points) pontos")
                }
                .font(.itimRegular(fontType: .body))
                .frame(maxHeight: geo.size.height * 0.2)
                .frame(minWidth: geo.size.width)
            }.frame(height: geo.size.height)
        }.background(BorderedBackground(foregroundColor: .offWhite, hasBorder: false))
    }
}

#Preview {
    PlayerGridItem(player:
        RoomUser(
            rankingPosition: 0, 
            points: 0,
            didVote: false,
            user: User(
                    id: UUID(),
                    name: "Name",
                    picture: "picture"
                )
            )
        )
}
