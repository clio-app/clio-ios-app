//
//  CustomTextfield.swift
//  clio-app
//
//  Created by Luciana Adrião on 10/11/23.
//

import SwiftUI

struct CustomTextfield: View {
    @Binding var inputUser: String
    @State var leadingIcon: String = ""
    @State var trailingIcon: String = "pencil.circle"
    @State var backgroundColor: Color
    @FocusState var isFocused: Bool
    var placeholder: String

    var onTapAction: (() -> Void)

    var body: some View {
        HStack {
            TextEditor(text: $inputUser)
                .foregroundColor( inputUser == placeholder ? .gray: .black )
                .onTapGesture {
                    if inputUser == placeholder {
                        inputUser = ""
                    }
                }
                .padding(.vertical, 4)
                .scrollContentBackground(.hidden)
                .multilineTextAlignment(.leading)
                .font(.itimRegular())
                .submitLabel(.done)
                .onSubmit {
                    onTapAction()
                }
                .focused($isFocused, equals: true)

                Image(systemName: isFocused ? "checkmark.circle" : trailingIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, alignment: .centerFirstTextBaseline)
                    .foregroundColor(.lapisLazuli)
                    .onTapGesture {
                        isFocused.toggle()
                    }
        }
        .padding(.horizontal, 8)
        .background(BorderedBackground(foregroundColor: .white, backgroundColor: backgroundColor, hasBorder: true))
    }
}
