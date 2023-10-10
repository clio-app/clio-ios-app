//
//  GameEndView.swift
//  clio-app
//
//  Created by Thiago Henrique on 10/10/23.
//

import SwiftUI
import ClioEntities

struct GameEndView: View {
    @State var users: [RoomUser]
    
    var body: some View {
        VStack {
            Text("Fim de jogo!")
                .font(.title)
                .bold()
            
            Text("Placar")
                .font(.title2)
                .bold()
            
            ScrollView {
                ForEach(users, id: \.user.id) { roomUser in
                    HStack {
                        Text("\(roomUser.rankingPosition): ")
                            .bold()
                            .padding([.trailing], 3)
                        
                        VStack {
                            Text(roomUser.user.name)
                                .bold()
                            
                            Text("Pontos: \(roomUser.points)")
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}
