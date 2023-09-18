//
//  ButtonTestView.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 18/09/23.
//

import SwiftUI

 struct ActionButton2: View {
     var title: String
     var foregroundColor: Color
     var backgroundColor: Color?
     var radius: CGFloat = 15
     var hasBorder: Bool

     var action: () -> Void

     var body: some View {
         Button(action: action) {
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
                 
                 StrokeText(
                    text: title,
                    borderWidth: 2,
                    borderColor: .black)
                 .foregroundColor(.white)
                 .font(.itimRegular(size: 24))
             }
         }
     }
 }

 struct SwiftUIButton_Previews: PreviewProvider {
     static var previews: some View {
         ActionButton2(title: "crie uma sessão", foregroundColor: .white, backgroundColor: Color("Brick"), hasBorder: true) {
         }
     }
 }
