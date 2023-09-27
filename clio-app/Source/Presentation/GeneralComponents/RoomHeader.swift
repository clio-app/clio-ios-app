//
//  RoomHeader.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 19/09/23.
//

import SwiftUI

struct RoomHeader: View {
    let roomName: String
    let roomTheme: String
    @State var withBorderBackground: Bool
    @Binding var masterImageName: String
    @Binding var usersImages: [String]
    
    var body: some View {
        HStack(spacing: 30) {
            VStack(alignment: .leading) {
                Text(roomName)
                    .font(.nightyDemo(fontType: .largeTitle))
                Text(roomTheme)
                    .font(.itimRegular(fontType: .title3))
            }
            .padding()
            .lineLimit(2)
            .foregroundColor(.black)
            
            Spacer()
            
            RadialUsers(
                usersList: $usersImages,
                masterUser: $masterImageName
            )
            .padding(.trailing, 40)
            .padding(.vertical, 40)
        }
        .background {
            BorderedBackground(
                foregroundColor: .white,
                backgroundColor: .customPink,
                hasBorder: withBorderBackground)
        }
    }
}


#Preview {
    RoomHeader(
        roomName: "Nome da Sala",
        roomTheme: "Tema da sala com um tema muito comprido",
        withBorderBackground: false,
        masterImageName: .constant("profile-picture-eye"),
        usersImages: .constant(["bonfire-picture", "bonfire-picture", "bonfire-picture"]))
}
