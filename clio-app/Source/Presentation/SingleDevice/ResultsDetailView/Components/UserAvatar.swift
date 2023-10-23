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
        VStack {
            Circle()
                .frame(width: 60, height: 60)
                .overlay {
                    Image(picture)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            Text(userName)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    UserAvatar(
        userName: "Name",
        picture: "profile-picture-eye"
    )
}
