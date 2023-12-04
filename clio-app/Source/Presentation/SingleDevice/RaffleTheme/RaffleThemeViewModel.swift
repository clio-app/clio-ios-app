//
//  RaffleThemeViewModel.swift
//  clio-app
//
//  Created by Luciana Adrião on 22/10/23.
//

import Foundation
import SwiftUI
import ClioDomain

final class RaffleThemeViewModel: ObservableObject {
    @Published var selectedTheme: String = ""
    @Published var isThemeSet: Bool = false
    @Published var timer: Timer?

    func stopTimerAndSetTheme() {
            timer?.invalidate()
            isThemeSet = true
    }

    func setTheme(from session: GameSession) {
        startThemeTimer(from: session, themes: session.themeManager.themes, interval: 0.1, duration: 3)
    }

    func startThemeTimer(from session: GameSession, themes: [String], interval: TimeInterval, duration: TimeInterval) {
        var currentIndex = 0
        var elapsedSeconds: TimeInterval = 0

        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            session.gameFlowParameters.sessionTheme = themes[currentIndex]
            currentIndex = (currentIndex + 1) % themes.count
            elapsedSeconds += interval

            // maximum time for player to tap the button

    //            if elapsedSeconds >= duration {
    //                timer.invalidate()
    //                gameSession.randomizeThemes()
    //            }
        }
    }

}
