//
//  StartView.swift
//  clio-app
//
//  Created by Thiago Henrique on 17/10/23.
//

import SwiftUI

struct StartView: View {
    @StateObject private var gameSession = GameSession()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()
                NavigationLink(destination: PlayersView()) {
                    Text("Play")
                }
            }
            .navigationTitle("")
        }
        .environmentObject(gameSession)
    }
}

#Preview {
    StartView()
}
