//
//  MasterCard.swift
//  clio-app
//
//  Created by Luciana Adrião on 20/09/23.
//

import SwiftUI

struct MasterInputCard: View {
    @Binding var userInputImage: String
    @Binding var userEntryText: String

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 16.0) {
                ImageCard(userInputImage: $userInputImage)
                LimitedInputTextField(inputUser: $userEntryText).font(.itimRegular(fontType: .body))
            }
            .frame(maxWidth: geo.size.width*0.9, maxHeight: geo.size.height*0.9)
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .background(BorderedBackground(foregroundColor: .customYellow, backgroundColor: .white, hasBorder: true))
    }
}

#Preview {
    MasterInputCard(userInputImage: .constant("liquid-bg"), userEntryText: .constant(""))
}
