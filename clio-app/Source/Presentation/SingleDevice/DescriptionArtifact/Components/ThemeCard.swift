//
//  ThemeCard.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 20/10/23.
//

import SwiftUI

struct ThemeCard: View {
    @Binding var theme: String
    
    var body: some View {
        Group {
            Text("Relacione a foto com o tema:")
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
    ThemeCard(theme: .constant("Temaaaaaaa grandaoooooooo giganteeeeeeeee"))
}
