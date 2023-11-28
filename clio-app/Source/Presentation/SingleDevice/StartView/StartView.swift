//
//  StartView.swift
//  clio-app
//
//  Created by Thiago Henrique on 17/10/23.
//

import SwiftUI
import Mixpanel

struct StartView: View {
    @StateObject private var gameSession = GameSession()    // state for reference
    @ObservedObject var router = Router()                   // binding for reference
    @State private var isPopupPresented: Bool = false

    var buttons: [ButtonMode] {
        [
            .init(name: "Modo \n singleplayer", image: .singleplayer, isDisabled: false, action: {
                router.clear()
            }),
            .init(name: "Jogue nesse dispositivo", image: .singledevice, isDisabled: false, action: {
                router.goToPlayersView()
            }),
            .init(name: "Jogue online", image: .multidevice, isDisabled: false, action: {
                isPopupPresented.toggle()
            }),
            .init(name: "Em breve", image: .unavailable, isDisabled: true, action: {})
        ]
    }

    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                Spacer()
                Image("welcome-to-clio")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 32)

                Spacer()
                ButtonGrid(buttons: buttons)
                Spacer()
            }
            .applyHelpButton(.Start)
            .navigationTitle("")
            .navigationDestination(for: Views.self) { destination in
                ViewFactory.viewForDestination(destination)
            }
            .onTapGesture {
                isPopupPresented = false
            }
            .popupNavigationView(show: $isPopupPresented) {
                CustomAlert(isPopupPresented: $isPopupPresented,
                            title: "Oops",
                            text: "Infelizmente esse modo de jogo ainda não está disponível!")
            }
            .clioBackground()
        }
        .environmentObject(gameSession)
        .environmentObject(router)
    }
}

#Preview {
    StartView()
}
