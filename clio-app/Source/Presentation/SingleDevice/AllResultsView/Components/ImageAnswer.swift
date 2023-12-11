//
//  ImageAnswer.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 28/11/23.
//

import SwiftUI

struct ImageAnswer: View {
    let userName: String
    let userPicture: String
    let imageData: Data
    let emojiName : String?
    
    let tapImage :() -> Void
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            UserAvatar(
                userName: userName,
                picture: userPicture,
                topAlignment: true
            )
            .offset(x: 15)
            ImageCard(imageData: imageData)
                .onTapGesture {
                    tapImage()
                }
                .offset(y: 40)
                .overlay {
                    if let emojiName = emojiName {
                        EmojiReaction(emojiName: emojiName)
                            .offset(y: 40)
                    }
                }
        }
        .padding(.bottom, 61)
        .padding(.top, 2)
    }
}

#Preview {
    ImageAnswer(
        userName: "Pessoinha",
        userPicture: "Lilac",
        imageData: (UIImage(named: "AppIcon")?.pngData())!,
        emojiName: "Emoji1",
        tapImage: {print("Tocou!!")})
}
