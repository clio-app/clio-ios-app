//
//  MasterInputView.swift
//  clio-app
//
//  Created by Luciana Adrião on 20/09/23.
//
import SwiftUI

struct MasterInputView: View {
    @State var userEntryText: String
    @State var userInputImage: String = "profile-picture-eye"

    private let maxWordCount: Int = 280

    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack(spacing: geo.size.height/10){

                    // MARK: - Top Header
                        Header()
                        .frame(height: geo.size.height * 0.12)

                    // MARK: - Card Content
                    MasterInputCard(userInputImage: $userInputImage, userEntryText: $userEntryText)
                        .padding()

                    // MARK: - Button
                    ActionButton(title: "Enviar", foregroundColor: userEntryText.count <= maxWordCount ? .customPink : .gray, hasBorder: false ){
                        // TODO: Send description to backend
                    }
                    // TODO: Solve repetitive code.
                    .disabled(userEntryText.count > maxWordCount)
                    .opacity(userEntryText.count <= maxWordCount ? 1.0 : 0.2)
                    .frame(width: geo.size.width*0.7, height: geo.size.height * 0.07)

                }
                .frame(maxHeight: geo.size.height * 0.9)
                .frame(height: geo.size.height)

            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 24)
            .keyboardAdaptive()
        }
        .background(Color.offWhite)
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}


#Preview {
    MasterInputView(userEntryText: "")
}
