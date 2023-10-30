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
                Text(LocalizedStringKey(text)).offset(x:  borderWidth, y:  borderWidth)
                Text(LocalizedStringKey(text)).offset(x:  borderWidth, y: -borderWidth)
                Text(LocalizedStringKey(text)).offset(x:  -borderWidth, y: -borderWidth)
                Text(LocalizedStringKey(text)).offset(x:  -borderWidth, y: borderWidth)

                // Midldle
                Text(LocalizedStringKey(text)).offset(x:  borderWidth)
                Text(LocalizedStringKey(text)).offset(x:  -borderWidth)
                Text(LocalizedStringKey(text)).offset(y: borderWidth)
                Text(LocalizedStringKey(text)).offset(y: -borderWidth)
            }
            .compositingGroup()
            .foregroundColor(borderColor)
            Text(LocalizedStringKey(text))
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
