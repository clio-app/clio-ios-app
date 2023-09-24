//
//  LobbyCards.swift
//  clio-app
//
//  Created by Luciana Adrião on 22/09/23.
//

import SwiftUI

struct MasterContainer: View {
    @Binding var username: String
    @Binding var userscore: Int

    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading, spacing: 0.5) {
                HStack {
                    Image("profile-picture-eye")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width * 0.3, height: geo.size.width * 0.3)

                    VStack {
                        Text(username) // Use username directly
                        Text("\(userscore) pontos") // Convert Int to String
                    }
                    .font(.itimRegular(fontType: .body))
                    .padding(.trailing, 20.0)
                    .frame(minWidth: geo.size.width * 0.7)

                }
                .padding(EdgeInsets(top: 16.0, leading: 10.0, bottom: 10.0, trailing: 16.0))
                .background(BorderedBackground(foregroundColor: .offWhite, hasBorder: false))
                
                Text("Mestre").font(.itimRegular(fontType: .title3))
                    .padding(.horizontal, 20)
                    .background(Capsule(style: .continuous).fill(Color.softGreen).overlay(content: {
                        Capsule(style: .continuous).stroke(.black, style: StrokeStyle(lineWidth: 2.0))
                    })
                )
                    .offset(x: 12.0)
            }
            .frame(width: geo.size.width)
            .foregroundColor(.black)
        }
    }
}


#Preview {
    MasterContainer(username: .constant("Prof.Juliano"), userscore: .constant(0))
}
