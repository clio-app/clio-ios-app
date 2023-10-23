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

    @State var input: String = ""
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ZStack {
                Color.white.ignoresSafeArea()
                Button("play") {
                    router.goToPlayersView()
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
