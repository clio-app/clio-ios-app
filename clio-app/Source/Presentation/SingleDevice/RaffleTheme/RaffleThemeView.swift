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
    @State private var isAnimationRunning: Bool = false

    var body: some View {
        VStack {
            Text("O tema esta sendo sorteado...")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 60)

            Spacer()

            if gameSession.gameFlowParameters.sessionTheme == "" {
                Button("Mudar tema") {
                    startAnimation()
                }
                .buttonStyle(.bordered)
            } else {

                if !isAnimationRunning {
                    Text("O tema é: ")
                        .font(.title3)
                }

                HStack {
                    Spacer()
                    themeSlot(theme: $selectedTheme)
                        .padding()
                    Spacer()
                }
                .padding(.horizontal, 24)
            }
            Spacer()
        }
        .background(.red)
        .onTapGesture {
            isAnimationRunning = false
        }
    }

    private func startAnimation() {
        let animationDuration: TimeInterval = 0.1
        let animationDurationRuntime: TimeInterval = 5.0
        isAnimationRunning = true

        let timer = Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: true) { timer in
            if isAnimationRunning {
//                withAnimation(.smooth(duration: animationDuration)) {
                    gameSession.randomizeThemes()
                    selectedTheme = gameSession.gameFlowParameters.sessionTheme
//                }
            } else {
                timer.invalidate()
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + animationDurationRuntime) {
//            withAnimation(.interpolatingSpring) {
                isAnimationRunning = false
                selectedTheme = gameSession.gameFlowParameters.sessionTheme
//            }
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
