//
//  MasterInputView.swift
//  clio-app
//
//  Created by Luciana Adrião on 20/09/23.
//
import SwiftUI
import ClioEntities

struct MasterInputView: View {
    @EnvironmentObject var gameViewModel: GameViewModel
    @State var userEntryText: String
    @State var userInputImage: UIImage = UIImage()

    // userList and masterUser receives and shows profile picture name
    @State var userList: [String]
    @State var masterUser: String
    @State var sended = false

    // TODO: MOVE setup variables to an easy access file and setup enum
    private let maxWordCount: Int = 280
    var sendImageTapped: ((Data, String) -> ())?

    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack(spacing: geo.size.height * 0.1){

                    // MARK: - Header and radial player view
                        HStack {
                            Header(userList: $userList, masterUser: $masterUser).scaledToFill()
                        }
                        .frame(height: geo.size.height * 0.12)

                    // MARK: - Card Content
                    MasterInputCard(
                        userInputImage: $userInputImage,
                        userEntryText: $userEntryText
                    )
                        .padding(.vertical)

                    // MARK: - Action Button
                    ActionButton(
                        title: "Enviar",
                        foregroundColor: userEntryText.count <= maxWordCount ? 
                            .customPink : .customPink.opacity(0.5),
                        hasBorder: false
                    ) {
                        if sended { return }
                        if let imageData = userInputImage.pngData() {
                            sendImageTapped?(imageData, userEntryText)
                            sended = true
                        }
                    }
                    .disabled(userEntryText.count > maxWordCount)
                    .frame(height: geo.size.height * 0.07)
                }
                .frame(maxWidth: geo.size.width * 0.9,maxHeight: geo.size.height * 0.9)
                .frame(width: geo.size.width, height: geo.size.height)
            }
            .scrollIndicators(.hidden)
            .keyboardAdaptive()
        }
        .background(Color.offWhite)
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden()
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}


#Preview {
    MasterInputView(userEntryText: "",
                    userList: ["bonfire-picture", "circles-picture", "profile-picture-eye",
                                         "bonfire-picture", "circles-picture", "profile-picture-eye"],
                    masterUser: "profile-picture-eye")
}
