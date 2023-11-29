//
//  InicialPhrase.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 28/11/23.
//

import SwiftUI

struct InitialPhrase: View {
    let phrase: String
    
    var body: some View {
        VStack (spacing: 10) {
            Text("A frase era...")
                .font(.itimRegular(fontType: .title3))
            DescriptionCard(description: phrase)
        }
    }
}

#Preview {
    InitialPhrase(phrase: "Frase inicial!")
}
