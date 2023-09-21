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
                    .resizable()
                    .position(x: midWidth, y: fullHeight * 0.2)
                    .scaleEffect(shouldAnimate ?  shouldMoveUp ? (1.1) : ((5.0)) : 1.1 )
                    .offset(y: shouldAnimate ? (shouldMoveUp ? 0 : (fullHeight*offsetMultiplier)) : 0)
//                    .offset(y: shouldAnimate ? (shouldMoveUp ? (-fullHeight) : (fullHeight*offsetMultiplier)) : 0)
                    .animation(.easeInOut(duration: animationDuration), value: shouldAnimate)


                Rectangle()
                    .fill(Color.customPink)
                    .position(x: midWidth, y: 0)
//                    .offset(y: shouldAnimate ? (shouldMoveUp ? (-fullHeight*1.3) : 0) : (-fullHeight + 100))
                    .animation(.easeInOut(duration: animationDuration), value: shouldAnimate)
                    .ignoresSafeArea()


                // MARK: - Transition color
//                Rectangle()
//                    .fill(Color.offWhite)
//                    .opacity(shouldAnimate ? 1.0 : 0.0)
//                    .animation(.bouncy(duration: animationDuration).delay(animationDuration), value: shouldAnimate)
//                    .ignoresSafeArea()
            }
        }
    }
}
