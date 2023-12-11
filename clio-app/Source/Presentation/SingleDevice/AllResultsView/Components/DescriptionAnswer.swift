//
//  DescriptionAnswer.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 28/11/23.
//

import SwiftUI

struct DescriptionAnswer: View {
    let description: String
    let userName: String
    let userPicture: String
    
    var body: some View {
        ZStack (alignment: .bottomTrailing) {
            UserAvatar(userName: userName, picture: userPicture, topAlignment: false)
                .offset(x: -20, y: 40)
            DescriptionCard(description: description)
                .padding(.horizontal, 2)
        }
        .padding(.bottom, 42)
    }
}

#Preview {
    DescriptionAnswer(
        description: "Uma descrição muito muito incrível!",
        userName: "Pessoinha",
        userPicture: "Lilac"
    )
}
