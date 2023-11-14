//
//  UserTextConfirmation.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 27/10/23.
//

import SwiftUI

struct UserTextConfirmation: View {
    var name: String
    
    var body: some View {
        VStack {
            Text("Você é...")
                .font(.itimRegular(fontType: .title3))

            Text(name)
                .font(.itimRegular(fontType: .largeTitle))
            + Text("?")
                .font(.itimRegular(fontType: .largeTitle))
        }
    }
}

#Preview {
    UserTextConfirmation(name: "Nome do usuário")
}
