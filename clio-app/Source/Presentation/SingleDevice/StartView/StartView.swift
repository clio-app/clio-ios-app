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

    var body: some View {
        NavigationStack(path: $router.path) {
            ZStack {
                Color.white.ignoresSafeArea()
                Button("play") {
                    router.goToPlayersView()
                    Mixpanel.mainInstance().track(event: "Play Tapped")
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("")
            .navigationDestination(for: Views.self) { destination in
                ViewFactory.viewForDestination(destination)
            }
        }
        .environmentObject(gameSession)
        .environmentObject(router)
    }
}

#Preview {
    StartView()
}
