//
//  CustomFirstPrompt.swift
//  clio-app
//
//  Created by Luciana Adrião on 10/11/23.
//

import SwiftUI

struct CustomFirstPrompt: View {
    @EnvironmentObject var session: GameSession
    @EnvironmentObject var router: Router
    @State var prompt: String = ""

    var body: some View {
        VStack {
            ThemeBubble(theme: session.gameFlowParameters.sessionTheme)

            Spacer()

            Text(LocalizedStringKey("Você aceita jogar com essa frase?"))
                .font(.itimRegular(fontType: .body))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)

            HStack {
                CustomTextfield(inputUser: $session.gameFlowParameters.firstRoundPrompt, backgroundColor: .lapisLazuli, placeholder: "Escreva a frase para a rodada") {
                }
            }
            .frame(height: 62)

            Spacer()

            ActionButton(title: "Aceitar", foregroundColor: .customYellow, backgroundColor: .white, hasBorder: true) {
                print("GoTo Popup method(take picture/ choose image) View")
                router.goToPhotoArtifactView()
            }
            .frame(height: 62)
        }
        .padding(.horizontal, 24)
        .adaptativeView()
        .clioBackground()
        .onAppear {
            prompt = session.gameFlowParameters.firstRoundPrompt
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .navigationBarBackButtonHidden(true)
        .applyHelpButton(.firstPrompt)
    }
}

#Preview {
    @ObservedObject var session = GameSession()
    session.gameFlowParameters.sessionTheme = "Biology"
    session.gameFlowParameters.firstRoundPrompt = "This is a random generated prompt from biology. If you like tap here and make your own prompt."

    let promptView = CustomFirstPrompt()
        .environmentObject(session)

    return promptView
}
















// TODO: move to View+Modifiers after merge
extension View {
    func adaptativeView() -> some View {
        return modifier(adaptiveView())
    }
}


struct adaptiveView: ViewModifier {

    func body(content: Content) -> some View {
        GeometryReader { geo in
            ScrollView {
                content
                .padding(.vertical, 48)
                .frame(width: geo.size.width, height: geo.size.height)
            }
            .keyboardAdaptive()
        }
    }
}
