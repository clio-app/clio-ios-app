//
//  ButtonGrid.swift
//  clio-app
//
//  Created by Luciana Adrião on 27/11/23.
//

import SwiftUI
import Mixpanel

struct ButtonGrid: View {
    @State private var animatedButtonCount: Int = 0
    var buttons: [ButtonMode]

    let columns = [
        GridItem(.adaptive(minimum: 150)) // Minimum width for each button
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 32) {
            ForEach(buttons.indices, id: \.self) { index in
                let button = buttons[index]
                CustomButton(buttonAction: {
                    Mixpanel.mainInstance().track(event: "\(button.image) Tapped")
                    button.action()
                }, icon: button.image.rawValue, text: button.name)
                .opacity(button.isDisabled ? 0.4 : 1.0)
                .scaleEffect(index == animatedButtonCount ? 0.5 : 1.0)
                .disabled(button.isDisabled)
                .padding(.horizontal, 8)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.2) {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                            animatedButtonCount += 1
                        }
                    }
                }
            }
        }
        .padding() // padding grid
    }
}


struct ButtonMode {
    let name: String
    let image: ImageMode
    let isDisabled: Bool
    let action: (() -> Void)
}

enum ImageMode: String {
    case singleplayer = "singleplayer-icon"
    case singledevice = "single-device-icon"
    case unavailable = "ghost-icon"
    case multidevice = "multi-device-icon"
}

//#Preview {
//    ButtonGrid()
//}
