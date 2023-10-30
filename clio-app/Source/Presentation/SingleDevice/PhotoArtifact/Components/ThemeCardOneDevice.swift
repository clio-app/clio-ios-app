//
//  ThemeCard.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 30/10/23.
//

import SwiftUI

struct ThemeCardOneDevice: View {
    let theme: String
    
    var body: some View {
        Group {
            Text("Tire uma foto que se relacione com:")
                .foregroundColor(.black)
                .font(.itimRegular(size: 18))
            + Text("\n \(theme)")
                .foregroundColor(.lapisLazuli)
                .font(.itimRegular(size: 20))
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}

#Preview {
    ThemeCardOneDevice(theme: "Um tema!")
}
