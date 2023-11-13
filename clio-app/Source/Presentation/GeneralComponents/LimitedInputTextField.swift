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
    var placeholder: String
    
    let secondaryAction: () -> Void

    var body: some View {
        GeometryReader { geo in
            TextEditor(text: $inputUser)
                .foregroundColor( inputUser == placeholder ? .gray: .black )
                .onTapGesture {
                    if inputUser == placeholder {
                        inputUser = ""
                    }
                    secondaryAction()
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .scrollContentBackground(.hidden)
                .multilineTextAlignment(.leading)
                .font(.itimRegular())
                .frame(
                    width: geo.size.width,
                    height: geo.size.height * 0.8,
                    alignment: .topLeading
                )
        }
        .background(RoundedRectangle(cornerRadius: 15.0, style: .continuous).stroke(.black, style: .init(lineWidth: 2.0)))
        .background(.white).clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay {
            countLetters
                .padding(.vertical, 5)
                .padding(.horizontal, 8)
        }
        .onAppear {
            inputUser = placeholder
        }
    }
}

extension LimitedInputTextField {
    var countLetters: some View {
        VStack {
            Spacer()
            HStack(alignment: .center) {
                Spacer()
                if inputUser == placeholder {
                    Text("0/\(maxInputCount)")
                        .padding(.top, 2)
                        .font(.itimRegular())
                        .foregroundColor(.black)
                } else {
                    Text("\(inputUser.count)/\(maxInputCount)")
                        .padding(.top, 2)
                        .font(.itimRegular())
                        .foregroundColor((inputUser.count > maxInputCount) ? .red : .black)
                }
            }
        }
    }
}



#Preview {
    LimitedInputTextField(maxInputCount: 280, inputUser: .constant(""), placeholder: "Escreva uma descrição sobre a imagem...", secondaryAction: {})
        .padding(.horizontal, 50)
}
