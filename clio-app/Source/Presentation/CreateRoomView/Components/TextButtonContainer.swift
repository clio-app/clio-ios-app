//
//  TextButtonContainer.swift
//  clio-app
//
//  Created by Luciana Adrião on 17/09/23.
//

import SwiftUI

struct TextButtonContainer: View {
    var textExplanation: String
    var buttonText: String
    var buttonColor: Color
    var buttonAction: () -> Void

    var body: some View {
        GeometryReader { geo in
            VStack {
                Text(textExplanation)
                    .font(.itimRegular(fontType: .title3))
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: geo.size.width, maxHeight: geo.size.height)

                SwiftUIButton(title: buttonText, foregroundColor: buttonColor, hasBorder: false, action: buttonAction)
            }
        }
    }
}

struct TextButtonContainer_Previews: PreviewProvider {
    static var previews: some View {
        TextButtonContainer(textExplanation: "Explicação do funcionamento do botão", buttonText: "Ele explica", buttonColor: .brick) {
                print("button Tapped")
        }
    }
}
