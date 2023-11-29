//
//  UserAvatar.swift
//  clio-app
//
//  Created by Thiago Henrique on 18/10/23.
//

import SwiftUI

struct UserAvatar: View {
    let userName: String
    let picture: String
    let topAlignment: Bool

    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .overlay {
                    Circle()
                        .stroke(lineWidth: 2.0)
                        .foregroundColor(.black)
                }
                .applyColor(picture)

            Text(userName)
                .foregroundStyle(.black)
                .font(.itimRegular(fontType: .body))
        }
        .padding(.top, topAlignment ? 6 : 30)
        .padding(.bottom, topAlignment ? 30 : 6)
        .padding(.horizontal, 18)
        .foregroundColor(.black)
        .background {
            BorderedBackground(foregroundColor: .offWhite, hasBorder: false)
        }
    }
}

#Preview {
    UserAvatar(
        userName: "Name",
        picture: "Lilac",
        topAlignment: true
    )
}
