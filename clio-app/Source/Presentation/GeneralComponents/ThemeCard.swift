//
//  ThemeCard.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 20/10/23.
//

import SwiftUI

struct ThemeCard: View {
    var title: String
    @Binding var theme: String
    
    var body: some View {
        Group {
            Text(title)
                .foregroundColor(.black)
            + Text("\n \(theme)")
                .foregroundColor(.lapisLazuli)
        }
        .font(.itimRegular(fontType: .headline))
        .multilineTextAlignment(.center)
        .padding()
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

#Preview {
    ThemeCard(title: "Relacione a foto com o tema:", theme: .constant("Temaaaaaaa grandaoooooooo giganteeeeeeeee"))
}
