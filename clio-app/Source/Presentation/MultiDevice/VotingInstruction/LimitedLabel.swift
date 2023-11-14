//
//  LimitedLabel.swift
//  clio-app
//
//  Created by Luciana Adrião on 10/10/23.
//

import SwiftUI

struct LimitedLabel: View {
    var selectedAnswer: String = "Escreva uma descrição sobre a imagem aaaaaaaaaaaaaaaaa..."

    var body: some View {
        ZStack {
            Text(selectedAnswer)
        }
    }
}

#Preview {
    LimitedLabel()
}
