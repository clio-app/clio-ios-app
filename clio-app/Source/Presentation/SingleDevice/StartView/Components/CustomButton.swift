//
//  CustomButton.swift
//  clio-app
//
//  Created by Luciana Adrião on 24/10/23.
//

import SwiftUI

struct CustomButton: View {
    let buttonAction: (()-> Void)
    let icon: String
    let text: String

    var body: some View {
        Button {
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            buttonAction()
        } label: {
            VStack(alignment: .center) {
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 92)
                    .frame(alignment: .top)
                    .padding(.vertical, 6)

                    Spacer()

                Text(NSLocalizedString(text, comment: ""))
                    .font(.itimRegular(fontType: .body))
                    .lineLimit(2)
                    .foregroundColor(.black)
                    .padding(.vertical, 6)

                Spacer()
                
            }
            .padding(.horizontal, 6)
            .frame(maxWidth: 180, maxHeight: 170)
            .background(BorderedBackground(foregroundColor: .customYellow,
                                           backgroundColor: .offWhite,
                                           hasBorder: true))
            .compositingGroup()
        }
    }
}

