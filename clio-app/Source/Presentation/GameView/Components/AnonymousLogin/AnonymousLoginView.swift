//
//  AnonymousLoginView.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 19/09/23.
//

import SwiftUI
import Combine

struct AnonymousLoginView: View {
    @EnvironmentObject var gameViewModel: GameViewModel
    @StateObject var vm = AnonymousLoginViewModel()
    
    var roomCode: String
    public var buttonPressedSubject = PassthroughSubject<Void, Never>()
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    RoomHeader(
                        roomName: vm.currentRoom?.room.name ?? "NAME_NOT_FOUND",
                        roomTheme: vm.currentRoom?.room.theme.title ?? "THEME_NOT_FOUND",
                        withBorderBackground: false,
                        masterImageName: $vm.masterImage,
                        usersImages: $vm.usersImages
                    )
                    
                    Spacer()
                    
                    SelectImageProfile(selectedImage: $vm.currentImage) {
                        withAnimation {
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            UIApplication.shared.endEditing()
                            vm.currentImage = changePicture(currentImageName: vm.currentImage) ?? vm.currentImage
                        }
                    }
                    .frame(
                        width: geometry.size.width * 0.35,
                        height: geometry.size.width * 0.35
                    )
                    
                    formField(
                        labelText: "Insira um nome para jogar",
                        placeHolder: "Escreva seu nome...",
                        input: $vm.userName
                    )
                    
                    Spacer()
                    
                    ActionButton(
                        title: "Entrar",
                        foregroundColor: .brick,
                        hasBorder: false) {
                            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                            UIApplication.shared.endEditing()
                            Task {
                                guard let user = await vm.createUser() else { return }
                                await gameViewModel.registerUserInRoom(user)
                            }
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
        .onAppear {
            Task {
                await vm.findRoom(id: roomCode)
            }
            gameViewModel.connectInRoom(roomCode)
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
        guard let currentIndex = vm.imagesList.firstIndex(of: currentImageName) else {
            return nil
        }
        
        let lastIndex = vm.imagesList.count - 1
        var nextImageIndex = 0
        
        if currentIndex != lastIndex {
            nextImageIndex = currentIndex + 1
        }
        return vm.imagesList[nextImageIndex]
    }
}

#Preview {
    AnonymousLoginView(roomCode: "ABC123")
}
