//
//  ShimmerEffectLoading.swift
//  clio-app
//
//  Created by Thiago Henrique on 13/11/23.
//

import SwiftUI

struct ShimmerEffectLoading: ViewModifier {
    @State private var isAnimating = false
    
    private var gradientColors: [Color] = [
        .gray.opacity(0.2),
        .clear,
        .gray.opacity(0.2)
    ]
    
    @State var startPoint: UnitPoint = .init(x: -1, y: 0.5)
    @State var endPoint: UnitPoint = .init(x: 0, y: 0.5)
    
    func body(content: Content) -> some View {
        content
            .overlay {
                LinearGradient(
                    colors: gradientColors,
                    startPoint: startPoint,
                    endPoint: endPoint
                )
                .onAppear {
                    withAnimation(.easeInOut(duration: 1)
                        .repeatForever(autoreverses: false)
                    ) {
                        startPoint = .init(x: 1.5, y: 0.5)
                        endPoint = .init(x: 2.5, y: 0.5)
                    }
                }
            }
            .clipped()
    }
}

extension View {
    func shimmer() -> some View {
        return modifier(ShimmerEffectLoading())
    }
}
