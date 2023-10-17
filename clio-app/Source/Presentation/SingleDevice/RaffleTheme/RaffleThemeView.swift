//
//  RaffleThemeView.swift
//  clio-app
//
//  Created by Thiago Henrique on 17/10/23.
//

import SwiftUI

struct RaffleThemeView: View {
    @EnvironmentObject var gameSession: GameSession
    
    var body: some View {
        if gameSession.gameFlowParameters.sessionTheme == "" {
            Button("Mudar tema") {
                gameSession.randomizeThemes()
            }
        } else {
            Text("O tema é: \(gameSession.gameFlowParameters.sessionTheme)")
        }
    }
}

#Preview {
    RaffleThemeView()
}
