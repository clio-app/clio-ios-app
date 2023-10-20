//
//  RaffleThemeView.swift
//  clio-app
//
//  Created by Thiago Henrique on 17/10/23.
//

import SwiftUI

struct RaffleThemeView: View {
    @EnvironmentObject var gameSession: GameSession
    @State private var selectedTheme: String = ""
    @State private var isThemeSet: Bool = false

    var body: some View {
        VStack {
            Text("O tema esta sendo sorteado...")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 60)

            Spacer()

            if gameSession.gameFlowParameters.sessionTheme == "" {
                Button("Mudar tema") {
                    setTheme()
                }
                .buttonStyle(.bordered)
            }  else {
                Text("O tema é: ")
                    .font(.title3)

                HStack {
                    Spacer()
                    themeSlot(theme: $gameSession.gameFlowParameters.sessionTheme)
                        .padding()
                    Spacer()
                }
                .padding(.horizontal, 24)
            }
            Spacer()
            
            NavigationLink(destination: EmptyView()) {
                Text("Continuar")
            }
        }
    }

    private func setTheme() {
        startThemeTimer(themes: gameSession.themeManager.themes, interval: 0.1, duration: 3)
    }

    private func startThemeTimer(themes: [String], interval: TimeInterval, duration: TimeInterval) {
        var currentIndex = 0
        var elapsedSeconds: TimeInterval = 0

        let timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            gameSession.gameFlowParameters.sessionTheme = themes[currentIndex]
            currentIndex = (currentIndex + 1) % themes.count
            elapsedSeconds += interval

            if elapsedSeconds >= duration {
                timer.invalidate()
                gameSession.randomizeThemes()
            }
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
