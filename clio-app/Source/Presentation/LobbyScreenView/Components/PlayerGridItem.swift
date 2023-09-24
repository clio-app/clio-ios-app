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
        VStack(alignment: .center) {
            
            Spacer()

            Image("profile-picture-eye")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 24.0)
                .frame(minWidth: 40.0, maxWidth: .infinity, minHeight: 40.0, maxHeight: .infinity)

            Group {
                Text("\(player.name)")
                Text("\(player.playerScore) pontos").padding(.bottom, 12.0)
            }
            .font(.itimRegular(fontType: .body))
        }
        .background(BorderedBackground(foregroundColor: .offWhite, hasBorder: false))
    }
}

#Preview {
    PlayerGridItem(player: .constant(Player(name: "Name")))
}
