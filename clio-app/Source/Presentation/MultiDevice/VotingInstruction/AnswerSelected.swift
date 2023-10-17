//
//  AnswerSelected.swift
//  clio-app
//
//  Created by Luciana AdriÃ£o on 10/10/23.
//

import SwiftUI

struct AnswerSelected: View {
    @Binding var isVoting: Bool
    @Binding var selectedText: String
    var geo: GeometryProxy

    var body: some View {
        ZStack(alignment:.topTrailing) {
            ScrollView (.vertical) {
                Text(selectedText)
                    .font(.itimRegular(fontType: .body))
                    .multilineTextAlignment(.leading)
                    .lineLimit(5)
                    .padding(.horizontal, 8)
                    .padding(.trailing, 18)
                    .padding(.vertical, 14)
            }
            .background(BorderedBackground(foregroundColor: .offWhite, hasBorder: false))
            .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.25)
            
            Button(action: {
                isVoting.toggle()
                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
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
            .onDisappear(perform: {
                isVoting.toggle()
            })
        }
    }
}

#Preview {
    GeometryReader { geometry in

        AnswerSelected(isVoting: .constant(true), selectedText: .constant("ASDSJ AKSDMS DAKSMD SKASMD JSK DMASDSKD SMJKDA <SMDMSKAD "), geo: geometry)
    }
}
