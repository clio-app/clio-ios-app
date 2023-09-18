//
//  ContentView.swift
//  clio-app
//
//  Created by Thiago Henrique on 15/09/23.
//

import SwiftUI

struct CreateRoomView: View {
    @State var user: String = "Visitante"
    @State private var moveImage: Bool = false
    @State private var shouldMoveUp: Bool = true

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // MARK: - Background

                Background(moveImage: $moveImage, time: .constant(0.5), move: $shouldMoveUp)

                // MARK: - Components
                VStack(spacing: geo.size.height/5) {
                    WelcomeUserHeader(user: $user)
                        .frame(maxWidth: geo.size.width*0.89, maxHeight: geo.size.height*0.13)
                        .frame(width: geo.size.width)


                    TextButtonContainer(textExplanation: "Crie uma sala e comece a jogar", buttonText: "Crie uma sala", buttonColor: .customYellow ) { withAnimation {

                        shouldMoveUp = false
                        moveImage.toggle()
                    }
                    }
                    .frame(height: geo.size.height*0.17)

                    TextButtonContainer(textExplanation: "É aluno?", buttonText: "Entre em uma sala", buttonColor: .blue) {

                        shouldMoveUp = true
                        moveImage.toggle()
                        
                    }
                    .frame(width: geo.size.width*0.6, height: geo.size.height*0.17)

                }.frame(maxWidth: geo.size.width*0.86).frame(width: geo.size.width)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRoomView()
    }
}
