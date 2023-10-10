//
//  VotingView.swift
//  clio-app
//
//  Created by Thiago Henrique on 10/10/23.
//

import SwiftUI
import ClioEntities

struct VotingView: View {
    @EnvironmentObject var gameViewModel: GameViewModel
    @State var descriptions: [Description]
    
    var body: some View {
        VStack {
            Text("Vote na descrição desejada: ")
                .bold()
                .padding([.bottom], 12)
            
            ScrollView {
                ForEach(descriptions, id: \.id) { description in
                    VStack {
                        Button(description.text) {
                            Task {
                                await gameViewModel.sendVoteToDescription(description)
                            }
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}


