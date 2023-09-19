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
    let masterImageName = "profile-picture-eye"
    @State var usersList: [String] = ["profile-picture-eye", "circles-picture", "bonfire-picture"]
    
    var body: some View {
        HStack(spacing: 25) {
            VStack(alignment: .leading) {
                Text(roomName)
                    .font(.nightyDemo(fontType: .largeTitle))
                Text(roomTheme)
                    .font(.itimRegular(fontType: .title3))
            }
            
            RadialUsers(
                usersList: $usersList,
                masterUser: masterImageName
            )
            .padding()
            .padding(.trailing, 10)
            .padding(.vertical,5)
        }
        .padding()
        .background {
            BorderedBackground(
                foregroundColor: .white,
                backgroundColor: .customPink,
                hasBorder: withBorderBackground)
        }
    }
}


#Preview {
    RoomHeader(roomName: "Nome da Sala", roomTheme: "Tema da sala com um tema muito comprido", withBorderBackground: false)
}
