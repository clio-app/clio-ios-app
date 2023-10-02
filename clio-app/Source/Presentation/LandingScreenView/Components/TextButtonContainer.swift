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
    var textColor: Color?
    var isStroke: Bool = false
    var buttonAction: () -> Void

    init(textExplanation: String, buttonText: String, buttonColor: Color, textColor: Color = .black, buttonAction: @escaping () -> Void) {
        self.textExplanation = textExplanation
        self.buttonText = buttonText
        self.buttonColor = buttonColor
        self.textColor = textColor
        self.buttonAction = buttonAction
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                if isStroke {
                    StrokeText(
                        text: textExplanation,
                        borderWidth: 2,
                        borderColor: .black
                    )
                    .multilineTextAlignment(.center)
                    .font(.itimRegular(fontType: .title3))
                    .foregroundColor(textColor)
                    .frame(maxWidth: geo.size.width - 20, maxHeight: geo.size.height)
                }
                else {
                    Text(textExplanation)
                        .font(.itimRegular(fontType: .title3))
                        .foregroundColor(textColor)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: geo.size.width - 20, maxHeight: geo.size.height)
                }

                ActionButton(title: buttonText, foregroundColor: buttonColor, hasBorder: false, action: buttonAction)
            }
        }
    }
    
    func isStroke(_ stroke: Bool) -> some View {
        var updatedView = self
        updatedView.isStroke = stroke
        return updatedView
    }
}

struct TextButtonContainer_Previews: PreviewProvider {
    static var previews: some View {
        TextButtonContainer(textExplanation: "Explicação do funcionamento do botão", buttonText: "Ele explica", buttonColor: .brick, textColor: .pink) {
                print("button Tapped")
        }
        .isStroke(true)
    }
}
