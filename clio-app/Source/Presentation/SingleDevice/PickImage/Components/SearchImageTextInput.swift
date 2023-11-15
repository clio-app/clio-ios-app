//
//  SearchImageTextInput.swift
//  clio-app
//
//  Created by Thiago Henrique on 13/11/23.
//

import SwiftUI

struct SearchImageTextInput: View {
    @Binding var isShowing: Bool
    @State var inputText = String()
    var generateImagesTapped: ((String) -> ())?
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center, spacing: 18) {
                Text(
                    "Generate Image Through Key Sentence"
                )
                .lineLimit(nil)
                .font(.itimRegular(fontType: .body))
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding([.top], 36)
                
                TextFieldView(
                    inputText: $inputText,
                    placeholder: "Example Random Theme",
                    color: .blue
                )
                .padding(.horizontal, geo.size.width * 0.1)
                
                ActionButton(
                    title: "Generate Images Button",
                    foregroundColor: inputText.isEmpty ?
                        .blue.opacity(0.1) :
                        .blue,
                    hasBorder: false
                ) {
                    if inputText != "" {
                        generateImagesTapped?(inputText)
                        UIApplication.shared.endEditing()
                    }
                }
                .frame(height: geo.size.height * 0.08)
                .frame(width: geo.size.width * 0.55)
                .padding(.horizontal, geo.size.width * 0.1)
                .padding(.top, 25)
                .padding(.bottom, 35)
                
            }
            .background(
                BorderedBackground(
                    foregroundColor: .offWhite,
                    backgroundColor: .blue,
                    hasBorder: true
                )
            )
            .ignoresSafeArea(.keyboard)
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            .padding(.horizontal, 10)
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

#Preview {
    SearchImageTextInput(isShowing: .constant(true))
}
