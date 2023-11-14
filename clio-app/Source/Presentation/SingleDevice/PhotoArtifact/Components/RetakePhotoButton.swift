//
//  RetakePhotoButton.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 18/10/23.
//

import SwiftUI

struct RetakePhotoButton: View {
    @State var backgroundColor: Color
    var fontColor: Color
    var action: () -> Void
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Circle()
                    .fill(backgroundColor)
                    .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.9)
                
                Image(systemName: "arrow.triangle.2.circlepath.camera.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(fontColor)
                    .frame(width: geo.size.width * 0.6, height: geo.size.height * 0.6)
            }
            .onTapGesture {
                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                let currentColor = backgroundColor
                backgroundColor = backgroundColor.opacity(0.5)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.33) {
                    backgroundColor = currentColor
                }
                action()
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

#Preview {
    RetakePhotoButton(backgroundColor: .gray, fontColor: .white) {
        print("Retake photho")
    }
}
