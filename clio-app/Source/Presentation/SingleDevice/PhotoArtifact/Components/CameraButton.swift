//
//  CameraButton.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 18/10/23.
//

import SwiftUI

struct CameraButton: View {
    @State var color: Color
    var action: () -> Void
    @State var canCapturePhoto = true
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Circle()
                    .stroke(color, lineWidth: 5)
                    .frame(
                        width: geo.size.width * 0.9 + 13,
                        height: geo.size.height * 0.9 + 13
                    )
                    .overlay {
                        Circle()
                            .fill(color)
                            .frame(
                                width: geo.size.width * 0.9,
                                height: geo.size.height * 0.9
                            )
                    }
            }
            .onTapGesture {
                if canCapturePhoto {
                    UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                    let currentColor = color
                    color = color.opacity(0.5)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.33) {
                        color = currentColor
                    }
                    action()
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

#Preview {
    CameraButton(color: .blue) {
        print("Apertouuu")
    }
}

