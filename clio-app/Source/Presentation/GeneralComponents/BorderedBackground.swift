//
//  BorderedBackground.swift
//  clio-app
//
//  Created by Luciana Adrião on 18/09/23.
//

import SwiftUI

struct BorderedBackground: View {
    var foregroundColor: Color
    var backgroundColor: Color?
    var radius: CGFloat = 15
    var hasBorder: Bool
    
    var body: some View {
        ZStack {
            if hasBorder {
                RoundedRectangle(cornerRadius: radius)
                    .foregroundColor(backgroundColor)
                    .overlay {
                        RoundedRectangle(cornerRadius: radius)
                            .stroke(style: StrokeStyle(lineWidth: 2.0))
                            .foregroundColor(.black)
                    }.offset(x: 7, y: 5)
            }
            
            RoundedRectangle(cornerRadius: radius)
                .fill(foregroundColor)
                .overlay {
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(style: StrokeStyle(lineWidth: 2.0))
                        .fill(.black)
                }
        }
    }
}

struct BorderedBackground_Previews: PreviewProvider {
    static var previews: some View {
        BorderedBackground(foregroundColor: .blue, hasBorder: true)
    }
}
