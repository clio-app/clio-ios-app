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
            VStack {
                Text("Tema: ")
                    .font(.itimRegular(fontType: .title3))
                Text(gameSession.gameFlowParameters.sessionTheme)
                    .font(.itimRegular(fontType: .largeTitle))
            }
            .padding(16)
            .overlay {
                RoundedRectangle(
                    cornerRadius: 16
                )
                .stroke(.black, lineWidth: 1)
            }
            
            VStack(spacing: 1){
                Text("A frase era...")
                    .font(.itimRegular(fontType: .title3))
                    .padding([.top])
                
                Text("Atividades vulcânicas")
                    .font(.itimRegular(fontType: .title3))
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
                    HStack(alignment: .bottom, spacing: 12) {
                        UserAvatar(
                            userName: gameSession.gameFlowParameters.didPlay[index].name,
                            picture: gameSession.gameFlowParameters.didPlay[index].picture
                        )
                        
                        ArtefactView(
                            artefact: gameSession.gameFlowParameters.didPlay[index].artefact!
                        )
                        .padding([.bottom], 16)
                        
                        Spacer()
                    }
                    .padding([.horizontal], 26)
                    .padding([.vertical], 32)
                }
            }
            .frame(height: 420)
            .padding([.vertical], 24)
            
        }
        .frame(height: 520)

    }
}

#Preview {
    @ObservedObject var gameSession = GameSession()
    gameSession.addPlayerInSession(
        name: "name01",
        image: "profile-picture-eye"
    )
    gameSession.addPlayerInSession(
        name: "name02",
        image: "bonfire-picture"
    )
    gameSession.addPlayerInSession(
        name: "name03",
        image: "profile-picture-eye"
    )
    gameSession.randomizeThemes()
    
    let user1 = gameSession.gameFlowParameters.players[0]
    let user2 = gameSession.gameFlowParameters.players[1]
    
    gameSession.gameFlowParameters.didPlay.append(
        User(
            id: user1.id,
            name: user1.name,
            picture: user1.picture,
            artefacts: SessionArtefacts(
                picture: UIImage(named: "AppIcon")!.pngData()!,
                description: "Funny description",
                masterId: user1.id
            )
        )
    )
    
    gameSession.gameFlowParameters.didPlay.append(
        User(
            id: user2.id,
            name: user2.name,
            picture: user2.picture,
            artefacts: SessionArtefacts(
                picture: Data(),
                description: "Funny description",
                masterId: user2.id
            )
        )
    )
    
    
    let resultView = ResultDetailsView()
        .environmentObject(gameSession)
    
    return resultView
}
