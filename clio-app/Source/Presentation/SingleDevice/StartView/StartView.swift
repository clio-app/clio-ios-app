//
//  StartView.swift
//  clio-app
//
//  Created by Thiago Henrique on 17/10/23.
//

import SwiftUI

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
                    customButton(buttonAction: {
                        router.goToPlayersView()
                    }, icon: "single-device-icon", text: "Jogue nesse dispositivo")

                    Spacer()

                    customButton(buttonAction: {
                        isPopupPresented.toggle()
                    }, icon: "multi-device-icon", text: "Jogue online \n")

                    Spacer()
                }
                Spacer()
            }
            .navigationTitle("")
            .navigationDestination(for: Views.self) { destination in
                ViewFactory.viewForDestination(destination)
            }
            .background {
                Color.white
                Image("clio-background")
                    .colorMultiply(Color.customYellow.opacity(0.2))
            }
            .ignoresSafeArea()
            .onTapGesture {
                isPopupPresented = false
            }
            .popupNavigationView(show: $isPopupPresented) {
                VStack(alignment: .center) {
                    Text("Oops")
                        .font(.nightyDemo(fontType: .largeTitle))


                    Text("Infelizmente esse modo de jogo ainda não está disponível!")
                        .font(.itimRegular(fontType: .body))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 36)

                    ActionButton(title: "Okay", foregroundColor: Color.lapisLazuli, hasBorder: false) {
                        isPopupPresented.toggle()
                    }
                    .frame(maxHeight: 42)
                    .padding(.horizontal, 42)
                }

                .foregroundColor(.black)
                .padding(.vertical, 36)
                .background(BorderedBackground(foregroundColor: Color.offWhite, backgroundColor: Color.lapisLazuli, hasBorder: true))
            }
        }
        .environmentObject(gameSession)
        .environmentObject(router)
    }
}

struct customButton: View {

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
                Text(text)
                    .font(.itimRegular(fontType: .button))
                    .foregroundColor(.black)
                    .lineLimit(2)
//                    .multilineTextAlignment(.center)
                    .padding(.vertical, 12)
            }
            .frame(maxWidth: 170, minHeight: 180)
            .background(BorderedBackground(foregroundColor: .customYellow,
                                           backgroundColor: .offWhite,
                                           hasBorder: true))
        }
    }
}

#Preview {
    StartView()
}
