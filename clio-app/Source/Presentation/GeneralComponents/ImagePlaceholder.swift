//
//  ImagePlaceholder.swift
//  clio-app
//
//  Created by Thiago Henrique on 14/11/23.
//

import SwiftUI

struct ImagePlaceholder: View {
    @State private var isAnimating = true
    
    private var gradientColors: [Color] = [
        .gray.opacity(0.3),
        .clear,
        .gray.opacity(0.3)
    ]
    
    @State var startPoint: UnitPoint = .init(x: -1, y: 0.5)
    @State var endPoint: UnitPoint = .init(x: 0, y: 0.5)
    
    var body: some View {
            Group {
                if isAnimating {
                    LinearGradient(
                        colors: gradientColors,
                        startPoint: startPoint,
                        endPoint: endPoint
                    )
                    .clipShape(.rect(cornerSize: CGSize(width: 30, height: 30)))
                } else {
                    Rectangle()
                        .foregroundStyle(.clear)
                }
            }
            .overlay {
                RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                .stroke(Color.gray, style: .init(lineWidth: 2))
                .foregroundStyle(.clear)
                .overlay {
                    Image(systemName: "photo.fill.on.rectangle.fill")
                    .resizable()
                    .foregroundStyle(.gray)
                    .aspectRatio(contentMode: .fill)
                    .padding(42)
                }
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 1)
                    .repeatForever(autoreverses: false)
                ) {
                    startPoint = .init(x: 1.5, y: 0.5)
                    endPoint = .init(x: 2.5, y: 0.5)
                }
            }
    }
}

#Preview {
    ImagePlaceholder()
        .frame(width: 180, height: 140)
}
