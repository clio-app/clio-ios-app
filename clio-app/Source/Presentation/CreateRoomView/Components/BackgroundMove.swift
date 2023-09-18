//
//  WavePattern.swift
//  clio-app
//
//  Created by Luciana Adrião on 17/09/23.
//

import SwiftUI

struct Background: View {
    @Binding var moveImage:Bool
    @Binding var time: Double
    @Binding var move: Bool

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("liquid-bg")
                    .position(x: geo.size.width / 2,
                              y: move ? (-geo.size.height/2) : (geo.size.height/3))
                    .scaleEffect(moveImage ?  2.0 : 1.1 )
                    .offset(y: moveImage ? (move ? (-geo.size.height) : geo.size.height) : (move ? geo.size.height : 0 ))
                    .animation(.easeInOut(duration: time), value: moveImage)

                Rectangle()
                    .fill(Color.customPink)
                    .offset(y: moveImage ? (move ? (-geo.size.height*1.3) : 0) : (-geo.size.height))
                    .animation(.easeInOut(duration: time), value: moveImage)
                    .ignoresSafeArea()
            }
        }
    }
}
