//
//  AnswerSelected.swift
//  clio-app
//
//  Created by Luciana Adrião on 10/10/23.
//

import SwiftUI

struct AnswerSelected: View {
    @Binding var hasVoted: Bool
    @Binding var selectedText: String
    var geo: GeometryProxy

    var body: some View {
        ZStack(alignment:.topTrailing) {
            Text(selectedText)
                .font(.itimRegular(fontType: .body))
                .multilineTextAlignment(.leading)
                .lineLimit(5)
                .padding(.horizontal, 8)
                .padding(.trailing, 18)
                .padding(.vertical, 14)
                .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.25)
                .background(BorderedBackground(foregroundColor: .offWhite, hasBorder: false))

            Button(action: {
                hasVoted.toggle()
            }, label: {
                Image("arrow-clockwise-path")
                    .resizable()
                    .scaledToFit()
                    .padding(10.0)
                    .background(Circle().fill(Color.peach))
                    .overlay {
                        Circle().stroke(lineWidth: 2.0)
                    }
                    .frame(height: geo.size.height * 0.1)
            })
            .offset(x: 16, y: -12)

        }

    }
}

    //#Preview {
    //    AnswerSelected(hasVoted: .constant(true), selectedText: .constant("ASJKDHSJHDAJH"))
    //}
