//
//  PlayerRow.swift
//  clio-app
//
//  Created by Luciana Adrião on 24/10/23.
//

import SwiftUI

struct PlayerRow: View {
    var color: String
    var playerName: String
    var delete: (() -> Void)

    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .applyColor(color)
                .overlay {
                    Circle()
                        .stroke(lineWidth: 2.0)
                }
                .frame(width: 45, alignment: .center)
            Text(LocalizedStringKey(playerName))
            Spacer()
            Button {
                delete()
            } label: {
                Image(systemName: "trash")
                    .scaledToFit()
                    .foregroundColor(.customPink)
            }
        }
        .font(.itimRegular(fontType: .body))
        .padding(.leading, 12)
        .padding(.trailing, 24)
        .padding(.vertical, 6)
        .background(
            Color.white
                .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
        )
        .overlay {
            RoundedRectangle(cornerRadius: 20.0, style: .continuous)
                .stroke(lineWidth: 2.0)
        }
        .padding(.vertical, 4)
    }
}

