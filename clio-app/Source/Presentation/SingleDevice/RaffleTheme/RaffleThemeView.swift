//
//  RaffleThemeView.swift
//  clio-app
//
//  Created by Thiago Henrique on 17/10/23.
//

import SwiftUI

struct RaffleThemeView: View {
    @EnvironmentObject var gameSession: GameSession
    @EnvironmentObject var router: Router
    @StateObject private var vm: RaffleThemeViewModel = RaffleThemeViewModel()

    var body: some View {
        VStack {
            Text("O tema esta sendo sorteado...")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 60)

            Spacer()

            Text("O tema é: ")
                .font(.title3)

            HStack {
                Spacer()
                themeSlot(theme: $gameSession.gameFlowParameters.sessionTheme)
                    .padding()
                Spacer()
            }
            .padding(.horizontal, 24)

            Spacer()
            if vm.isThemeSet {
                Button("Continuar") {
                    router.clear()
                    router.goToSelectPlayer()
                }.buttonStyle(.borderedProminent)
            } else {
                Button("Parar") {
                    vm.stopTimerAndSetTheme()
                    gameSession.selectFirstRoundPrompt()

                    print(gameSession.gameFlowParameters.firstRoundPrompt)
                }
                .buttonStyle(.bordered)
            }

            Spacer()
        }.onAppear {
            vm.setTheme(from: gameSession)
        }
        .onDisappear(perform: {
            vm.stopTimerAndSetTheme()
        })
        .foregroundColor(.black)
        .background {
            Color.white.ignoresSafeArea()
        }
    }
}

struct themeSlot: View {
    @Binding var theme: String

    var body: some View {
        Text(theme)
            .font(.largeTitle)
    }
}

#Preview {
    RaffleThemeView()
}
