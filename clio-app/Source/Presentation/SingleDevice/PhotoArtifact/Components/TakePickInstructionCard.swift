//
//  TakePickInstructionCard.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 30/11/23.
//

import SwiftUI

struct TakePickInstructionCard: View {
    
    @Binding var theme: String
    let width: CGFloat?
    let height: CGFloat?
    
    var body: some View {
        Group {
            Text(LocalizedStringKey("Tire uma foto que se relacione com:"))
                .foregroundColor(.black)
                .font(.itimRegular(size: 18))
            + Text("\n \(theme)")
                .foregroundColor(.lapisLazuli)
                .font(.itimRegular(size: 20))
        }
        .multilineTextAlignment(.center)
        .padding()
        .frame(width: width, height: height)
        .background{
            BorderedBackground(foregroundColor: .white, hasBorder: false)
        }

    }
}

#Preview {
    TakePickInstructionCard(theme: .constant("Um tema aleatório"), width: 300, height: 100)
}
