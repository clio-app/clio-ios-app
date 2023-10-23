//
//  UserAvatar.swift
//  clio-app
//
//  Created by Thiago Henrique on 18/10/23.
//

import SwiftUI

struct UserAvatar: View {
    let userName: String
    var body: some View {
        VStack {
            Circle()
                .frame(width: 60, height: 60)
            Text(userName)
        }
    }
}

#Preview {
    UserAvatar(userName: "Name")
}
