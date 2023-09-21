//
//  AnonymousLoginView.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 19/09/23.
//

import SwiftUI
import Combine

struct AnonymousLoginView: View {
    private let imagesList = ["bonfire-picture", "circles-picture", "profile-picture-eye"]
    
    public var buttonPressedSubject = PassthroughSubject<Void, Never>()
    
    @State var masterImage: String = "circles-picture"
    @State var usersImages: [String]
    @State var userName: String = ""
    @State var currentImage: String {
        didSet {
            if usersImages.isEmpty {
                masterImage = currentImage
            } 
            else {
                let lastIndex = usersImages.count - 1
                usersImages[lastIndex] = currentImage
            }
        }
    }
    
    init(masterImage: String? = nil, usersImages: [String] = []) {
        if let masterImage = masterImage {
            self.masterImage = masterImage
            self.usersImages = usersImages + ["bonfire-picture"]
            self.currentImage = "bonfire-picture"
        } else {
            self.masterImage = "profile-picture-eye"
            self.currentImage = "profile-picture-eye"
            self.usersImages = usersImages
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    RoomHeader(
                        roomName: "Nome da Sala",
                        roomTheme: "Tema da Sala",
                        withBorderBackground: false,
                        masterImageName: $masterImage,
                        usersImages: $usersImages
                    )
                    
                    Spacer()
                    
                    SelectImageProfile(selectedImage: $currentImage) {
                        withAnimation {
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            UIApplication.shared.endEditing()
                            currentImage = changePicture(currentImageName: currentImage) ?? currentImage
                        }
                    }
                    .frame(
                        width: geometry.size.width * 0.35,
                        height: geometry.size.width * 0.35
                    )
                    
                    formField(
                        labelText: "Insira um nome para jogar",
                        placeHolder: "Escreva seu nome...",
                        input: $userName
                    )
                    
                    Spacer()
                    
                    ActionButton(
                        title: "Entrar",
                        foregroundColor: .brick,
                        hasBorder: false) {
                            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                            UIApplication.shared.endEditing()
                            buttonPressedSubject.send()
                        }
                        .frame(height: 62)
                }
                .padding(.bottom, 35)
                .padding(.top, 20)
                .padding(.horizontal, 20)
                .frame(
                    width: geometry.size.width,
                    height: geometry.size.height
                )
            }
            .keyboardAdaptive()
        }
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .background {
            Color.white
                .ignoresSafeArea()
        }
    }
    
    private func formField(labelText: String, placeHolder: String, input: Binding<String>) -> some View {
        VStack {
            Text(labelText)
                .font(.itimRegular(fontType: .title3))
                .foregroundColor(.black)
            
            TextFieldView(
                inputText: input,
                placeholder: placeHolder,
                color: .brick
            )
        }
    }
    
    private func changePicture(currentImageName: String) -> String? {
        guard let currentIndex = imagesList.firstIndex(of: currentImageName) else {
            return nil
        }
        
        let lastIndex = imagesList.count - 1
        var nextImageIndex = 0
        
        if currentIndex != lastIndex {
            nextImageIndex = currentIndex + 1
        }
        return imagesList[nextImageIndex]
    }
}

#Preview {
    AnonymousLoginView(masterImage: "bonfire-picture", usersImages: ["bonfire-picture", "bonfire-picture", "bonfire-picture"])
}
