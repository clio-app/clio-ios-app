//
//  TakePictureModePopup.swift
//  clio-app
//
//  Created by Thiago Henrique on 14/11/23.
//

import SwiftUI

struct TakePictureModePopup: View {
    var inputPhrase: String
    var takePictureButtonTapped: (() -> Void)?
    var pickImageButtonTapped: (() -> Void)?
    @Binding var isShowing: Bool
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center, spacing: 18) {
                VStack {
                    Text("Take Picture Mode Sentence")
                        .lineLimit(nil)
                        .font(.itimRegular(fontType: .headline))
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding([.top], 36)
                        .padding([.horizontal])
                    
                    Text(inputPhrase)
                        .lineLimit(nil)
                        .font(.itimRegular(fontType: .body))
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding([.top], 24)
                        .padding([.horizontal])
                }
                
                
                ActionButton(
                    title: "Take Picture Button",
                    foregroundColor: .blue,
                    hasBorder: false
                ) {
                    takePictureButtonTapped?()
                }
                .frame(height: geo.size.height * 0.07)
                .frame(width: geo.size.width * 0.75)
                .padding(.top, 25)
                
                ActionButton(
                    title: "Pick Image Button",
                    foregroundColor: .blue,
                    hasBorder: false
                ) {
                    pickImageButtonTapped?()
                }
                .frame(height: geo.size.height * 0.07)
                .frame(width: geo.size.width * 0.75)
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
            .keyboardAdaptive()
            .padding(.horizontal, 10)
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

#Preview {
    TakePictureModePopup(
        inputPhrase: "Floresta Amazônica: Os Pulmões da Terra.",
        isShowing: .constant(true)
    )
}

