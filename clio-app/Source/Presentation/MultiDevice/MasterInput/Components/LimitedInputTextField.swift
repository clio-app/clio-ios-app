//
//  LimitedInputTextField.swift
//  clio-app
//
//  Created by Luciana Adrião on 20/09/23.
//

import SwiftUI

struct LimitedInputTextField: View {
    var maxInputCount: Int
    @Binding var inputUser: String
    var placeholder: String = "Escreva uma descrição sobre a imagem..."

    var body: some View {
        VStack {
            ScrollView(.vertical){
                TextField(text: $inputUser, axis: .vertical) {
                    Text(placeholder)
                        .foregroundColor(.gray)
                }
                .font(.itimRegular())
                .foregroundColor(.black)
                .lineLimit(5)
                .multilineTextAlignment(.leading)
//                .overlay(
//                    HStack {
//                        Spacer()
//                    })
            }
            .scrollIndicators(.hidden)

            HStack(alignment: .center) {
                Spacer()
                Text("\(inputUser.count)/\(maxInputCount)")
                    .padding(.top, 2)
                    .foregroundColor(.black)
            }
            Spacer()
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(RoundedRectangle(cornerRadius: 15.0, style: .continuous).stroke(.black, style: .init(lineWidth: 2.0)))
        .background(.white).clipShape(RoundedRectangle(cornerRadius: 15))
    }
}



#Preview {
    LimitedInputTextField(maxInputCount: 280, inputUser: .constant("Abralskdmksjdksa"))
}
