//
//  LobbyHeader.swift
//  clio-app
//
//  Created by Luciana Adrião on 27/09/23.
//

import SwiftUI

struct LobbyHeader: View {
    @Binding var lobbyName: String
    @Binding var lobbyTheme: String
    @Binding var lobbyPasscode: String
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 1.0) {
            HStack {
                VStack(alignment: .leading) {
                    Text(lobbyName)
                        .font(.nightyDemo(fontType: .largeTitle))
                    Text(lobbyTheme)
                        .font(.itimRegular(fontType: .title3))
                }
                .padding(.all, 20.0)
                Spacer()
                
            }.background(BorderedBackground(foregroundColor: .offWhite, hasBorder: false))
            
            StrokeText(text: lobbyPasscode, borderWidth: 2.0, borderColor: .black)
                .foregroundColor(.white).font(.itimRegular(fontType: .title3))
                .padding(.horizontal, 20)
                .background(
                    Capsule(style: .continuous)
                        .fill(Color.softGreen)
                        .overlay{ 
                            Capsule(style: .continuous)
                                .stroke(.black, style: StrokeStyle(lineWidth: 2.0))
                        }
                )
        }
    }
}

#Preview {
    LobbyHeader(lobbyName: .constant("Turma A"), lobbyTheme: .constant("1ª Guerra Mundial"), lobbyPasscode: .constant("XSJAMP"))
}
