//
//  ArrowDownButton.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 29/11/23.
//

import SwiftUI

struct ArrowDownButton: View {
    var action: () -> Void
    
    var body: some View {
        Image(systemName: "chevron.down.circle")
            .resizable()
            .frame(width: 54, height: 54)
            .background {
                Circle()
                    .fill(Color.brick)
            }
            .onTapGesture {
                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                action()
            }
    }
}

#Preview {
    ArrowDownButton() {print("Oi Mundo!")}
}
