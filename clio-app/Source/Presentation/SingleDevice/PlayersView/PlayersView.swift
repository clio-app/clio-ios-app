//
//  PlayersView.swift
//  clio-app
//
//  Created by Thiago Henrique on 17/10/23.
//

import SwiftUI

struct PlayersView: View {
    @EnvironmentObject var session: GameSession
    
    var body: some View {
        VStack {
            Text("Players")
            
            ForEach(session.gameFlowParameters.players, id: \.id) { player in
                Text("Player: \(player.name)")
            }
            
            Button("Adicionar Player") {
                session.addPlayerInSession(name: "\(Int.random(in: 0..<10))", image: "")
            }
            
            NavigationLink(destination: RaffleThemeView()) {
                Text("Start")
            }
        }
        .alert(isPresented: $session.alertError.showAlert) {
            Alert(title: Text("Error"), message: Text(session.alertError.errorMessage))
        }
    }
}

#Preview {
    PlayersView()
}
