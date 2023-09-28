//
//  PlayerGridItem.swift
//  clio-app
//
//  Created by Luciana Adrião on 23/09/23.
//

import SwiftUI

struct PlayerGridItem: View {
    @Binding var player: Player

    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center) {
                Image("profile-picture-eye")
                    .resizable()
                    .scaledToFit()
                    .offset(y: geo.size.height * 0.05)
                    .frame(maxHeight: geo.size.height * 0.3)
                Group {
                    Text("\(player.name)")
                    Text("\(player.playerScore) pontos")
                }
                .font(.itimRegular(fontType: .body))
                .frame(maxHeight: geo.size.height * 0.2)
                .frame(minWidth: geo.size.width)
            }.frame(height: geo.size.height)
        }.background(BorderedBackground(foregroundColor: .offWhite, hasBorder: false))
    }
}

#Preview {
    PlayerGridItem(player: .constant(Player(name: "Name")))
}
