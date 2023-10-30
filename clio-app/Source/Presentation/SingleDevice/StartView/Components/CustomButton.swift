//
//  CustomButton.swift
//  clio-app
//
//  Created by Luciana Adrião on 24/10/23.
//

import SwiftUI

struct CustomButton: View {

    var buttonAction: (()-> Void)
    var icon: String
    var text: String

    var body: some View {
        Button {
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            buttonAction()
        } label: {
            VStack(alignment:.center) {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 92)
                    .padding(.top, 8)
                Text(LocalizedStringKey(text))
                    .font(.itimRegular(fontType: .button))
                    .foregroundColor(.black)
                    .padding(.vertical, 12)
            }
            .frame(maxWidth: 170, maxHeight: 180)
            .background(BorderedBackground(foregroundColor: .customYellow,
                                           backgroundColor: .offWhite,
                                           hasBorder: true))
        }
    }
}

