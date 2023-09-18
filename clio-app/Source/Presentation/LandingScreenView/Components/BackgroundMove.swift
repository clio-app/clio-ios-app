//
//  WavePattern.swift
//  clio-app
//
//  Created by Luciana Adrião on 17/09/23.
//

import SwiftUI

struct Background: View {
    @Binding var shouldAnimate:Bool
    @Binding var animationDuration: Double
    @Binding var shouldMoveUp: Bool


    var body: some View {
        GeometryReader { geo in
            let midWidth: CGFloat = geo.size.width / 2
            let fullHeight: CGFloat = geo.size.height
            let offsetMultiplier: CGFloat = 0.9

            ZStack {
                Image("liquid-bg")
                    .position(x: midWidth, y: fullHeight * 0.3)
                    .scaleEffect(shouldAnimate ?  shouldMoveUp ? (1.1) : ((2.0)) : 1.1 )
                    .offset(y: shouldAnimate ? (shouldMoveUp ? (-fullHeight) : (fullHeight*offsetMultiplier)) : 0)
                    .animation(.easeInOut(duration: animationDuration), value: shouldAnimate)

                Rectangle()
                    .fill(Color.customPink)
                    .offset(y: shouldAnimate ? (shouldMoveUp ? (-fullHeight*1.3) : 0) : (-fullHeight + 100))
                    .animation(.easeInOut(duration: animationDuration), value: shouldAnimate)
                    .ignoresSafeArea()
            }
        }
    }
}
