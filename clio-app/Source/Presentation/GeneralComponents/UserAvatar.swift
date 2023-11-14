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

    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                    .frame(width: 50, height: 50)
                    .overlay {
                        Circle()
                            .stroke(lineWidth: 3.0)
                            .foregroundColor(.black)
                    }
                    .applyColor(picture)

            Text(userName)
                .foregroundStyle(.black)
                .font(.itimRegular(fontType: .body))
        }
        .padding(.vertical, 10)
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
        picture: "Lilac"
    )
}
