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

    /*private*/ var maxWordCount: Int = 280

    var body: some View {
        // TODO: fix resize view when keyboard is being used.
        GeometryReader { geo in
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
                .disabled(userEntryText.count > maxWordCount)
                .opacity(userEntryText.count <= maxWordCount ? 1.0 : 0.3)
                .frame(height: geo.size.height * 0.07)

                // TODO: Solve repetitive code.
            }
            .padding(.top)
        }
        .padding()
        .background(Color.offWhite)
    }
}


#Preview {
    MasterInputView(userEntryText: "")
}
