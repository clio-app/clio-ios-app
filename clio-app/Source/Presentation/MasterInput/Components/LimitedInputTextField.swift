//
//  LimitedInputTextField.swift
//  clio-app
//
//  Created by Luciana Adrião on 20/09/23.
//

import SwiftUI

struct LimitedInputTextField: View {
    @Binding var inputUser: String
    var placeholder: String = "Escreva uma descrição sobre a imagem..."

    var body: some View {
        GeometryReader { geo in
            VStack {
                TextField("", text: $inputUser)
                    .multilineTextAlignment(.leading)
                    .textFieldStyle(.roundedBorder)
                    .overlay(
                        Text(placeholder)
                            .foregroundColor(Color.gray)
                            .opacity(inputUser.isEmpty ? 1.0 : 0.0) // Show placeholder only when input is empty
                    )

                HStack(alignment: .center) {
                    Spacer()
                    Text("\(inputUser.count)/280")
                        .padding(.top, 2)
                        .foregroundColor(.black)
                }
            }
            .padding()
            .background(BorderedBackground(foregroundColor: .clear, backgroundColor: .clear, hasBorder: false))
            .background(.white).clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}



#Preview {
    LimitedInputTextField(inputUser: .constant("Abra"))
}
