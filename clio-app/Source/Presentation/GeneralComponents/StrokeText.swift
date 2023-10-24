//
//  NewRoomView.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 15/09/23.
//

import SwiftUI

struct StrokeText: View {
    let text: String
    let borderWidth: CGFloat
    let borderColor: Color

    var body: some View {
        ZStack{
            ZStack{
                // Corners
                Text(text).offset(x:  borderWidth, y:  borderWidth)
                Text(text).offset(x:  borderWidth, y: -borderWidth)
                Text(text).offset(x:  -borderWidth, y: -borderWidth)
                Text(text).offset(x:  -borderWidth, y: borderWidth)
                
                // Midldle
                Text(text).offset(x:  borderWidth)
                Text(text).offset(x:  -borderWidth)
                Text(text).offset(y: borderWidth)
                Text(text).offset(y: -borderWidth)
            }
            .compositingGroup()
            .foregroundColor(borderColor)
            Text(text)
        }
    }
}

struct StrokeText_Previews: PreviewProvider {
    static var previews: some View {
        StrokeText(text: "Sample Text", borderWidth: 2, borderColor: .black)
            .foregroundColor(.white)
            .font(.nightyDemo(fontType: .title3))
    }
}
