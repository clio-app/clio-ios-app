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

    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                Spacer()
                Image("welcome-to-clio")
                    .resizable()
                    .scaledToFit()
                Spacer()

                HStack(alignment:.top) {
                    Spacer()
                    CustomButton(buttonAction: {
                        Mixpanel.mainInstance().track(event: "Play Local Tapped")
                        router.goToPlayersView()
                    }, icon: "single-device-icon", text: "Jogar nesse dispositivo")

                    Spacer()

                    CustomButton(buttonAction: {
                        Mixpanel.mainInstance().track(event: "Play Online Tapped")
                        isPopupPresented.toggle()
                    }, icon: "multi-device-icon", text: "Jogar online")

                    Spacer()
                }
                Spacer()
            }
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
