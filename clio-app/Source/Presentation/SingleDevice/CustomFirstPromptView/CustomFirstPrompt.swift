//
//  CustomFirstPrompt.swift
//  clio-app
//
//  Created by Luciana Adrião on 10/11/23.
//

import SwiftUI

struct CustomFirstPrompt: View {
    @EnvironmentObject var session: GameSession
    @State var prompt: String = ""

    var body: some View {
        VStack {
            ThemeBubble(theme: session.gameFlowParameters.sessionTheme)

            Text(LocalizedStringKey("Você aceita jogar com essa frase?"))
                .font(.itimRegular(fontType: .body))
                .multilineTextAlignment(.center)

            TextFieldView(inputText: $prompt, placeholder: "Escreva a frase", color: .brick)
                .padding(.horizontal, 24)
        }
        .clioBackground()
    }
}

#Preview {
    @ObservedObject var session = GameSession()
    session.gameFlowParameters.sessionTheme = "Biology"
    session.gameFlowParameters.firstRoundPrompt = "First round prompt for this"

    let promptView = CustomFirstPrompt()
        .environmentObject(session)

    return promptView
}
