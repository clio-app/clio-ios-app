//
//  ButtonsToConfirmation.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 27/10/23.
//

import SwiftUI

struct ButtonsToConfirmation: View {
    var confirmationAction: () -> Void
    var negationAction: () -> Void
    var isLastUser: Bool
    
    var body: some View {
        VStack {
            ActionButton(
                title: "Sim",
                foregroundColor: .softGreen,
                backgroundColor: .white,
                hasBorder: true) {
                    confirmationAction()
                    
                }
            ActionButton(
                title: "Não",
                foregroundColor: .sky,
                backgroundColor: .white,
                hasBorder: true) {
                    negationAction()
                }
                .disabled(isLastUser)
                .opacity(isLastUser ? 0.2 : 1)
        }
    }
}

#Preview {
    ButtonsToConfirmation(confirmationAction: {}, negationAction: {}, isLastUser: true)
}
