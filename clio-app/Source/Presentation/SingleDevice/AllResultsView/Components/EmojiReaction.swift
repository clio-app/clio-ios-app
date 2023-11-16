//
//  EmojiReaction.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 16/11/23.
//

import SwiftUI

struct EmojiReaction: View {
    let emojiName: String
    let percentageFromParentView: CGFloat = 0.2
    var body: some View {
        GeometryReader { geo in
            VStack {
                Image(emojiName)
                    .resizable()
                    .scaledToFit()
                    .padding(3)
                    .padding(.leading, 2)
                    .padding(.top, 3)
                    .background{
                        Color.white
                    }
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(.black, lineWidth: 2)
                    }
                    .frame(
                        width: geo.size.width * percentageFromParentView,
                        height: geo.size.width * percentageFromParentView
                    )
                    .offset(
                        x:(geo.size.width * percentageFromParentView) / 4,
                        y:(geo.size.width * percentageFromParentView) / 3
                    )
                
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .bottomTrailing)
            
        }
    }
}

#Preview {
    EmojiReaction(emojiName: "Emoji1")
}
