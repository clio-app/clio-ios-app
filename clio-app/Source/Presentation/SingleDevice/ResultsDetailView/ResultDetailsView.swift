//
//  ResultDetailsView.swift
//  clio-app
//
//  Created by Thiago Henrique on 18/10/23.
//

import SwiftUI
import ClioEntities

struct ResultDetailsView: View {
    @EnvironmentObject var gameSession: GameSession
    
    var body: some View {
        VStack {
            Text(gameSession.gameFlowParameters.sessionTheme)
                .font(.largeTitle)
            
            VStack {
                Text("A frase era...")
                    .padding([.top])
                
                Text("Atividades vulcânicas")
                    .padding(16)
                    .overlay {
                        RoundedRectangle(
                            cornerRadius: 16
                        )
                        .stroke(.black, lineWidth: 1)
                    }
            }
            
            Spacer()
            
            ScrollView {
                ForEach((0..<gameSession.gameFlowParameters.didPlay.count), id: \.self) { index in
                    HStack(alignment: .top, spacing: 12) {
                        
                        UserAvatar(
                            userName: gameSession.gameFlowParameters.didPlay[index].name
                        )
                        
                        ArtefactView(
                            artefact: gameSession.gameFlowParameters.didPlay[index].artefact!
                        )
                        
                        Spacer()
                        
                    }
                    .padding([.horizontal], 26)
                    .padding([.vertical], 32)
                }
            }
            .frame(height: 480)
            .padding([.vertical], 24)
            
        }
        .frame(height: 520)

    }
}

#Preview {
    @ObservedObject var gameSession = GameSession()
    gameSession.addPlayerInSession(name: "name01", image: "")
    gameSession.addPlayerInSession(name: "name02", image: "")
    gameSession.addPlayerInSession(name: "name03", image: "")
    gameSession.randomizeThemes()
    
    let user = gameSession.gameFlowParameters.players[0]
    
    gameSession.gameFlowParameters.didPlay.append(
        User(
            id: user.id,
            name: user.name,
            picture: user.picture,
            artefacts: SessionArtefacts(
                picture: UIImage(systemName: "star")!.pngData()!,
                description: "Funny description",
                masterId: user.id
            )
        )
    )
    
    gameSession.gameFlowParameters.didPlay.append(
        User(
            id: user.id,
            name: user.name,
            picture: user.picture,
            artefacts: SessionArtefacts(
                picture: UIImage(systemName: "star")!.pngData()!,
                description: "Funny description",
                masterId: user.id
            )
        )
    )
    
    
    let resultView = ResultDetailsView()
        .environmentObject(gameSession)
    
    return resultView
}
