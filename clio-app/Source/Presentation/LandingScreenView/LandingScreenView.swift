//
//  LandingScreenView.swift
//  clio-app
//
//  Created by Luciana Adrião on 18/09/23.
//

import SwiftUI

struct LandingScreenView: View {
    @State var user: String = "Visitante"
    @State private var moveImage: Bool = false
    @State private var isMovingUp: Bool = false
    @State private var isPopupPresented: Bool = false
    @State private var goToCreateRoomView = false
    @State private var roomCode: String?
    @State private var goToGameView = false

    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                ZStack {
                    Color.white
                        .ignoresSafeArea()
                    
                    // MARK: - Background
                    Background(shouldAnimate: $moveImage, animationDuration: .constant(0.5), shouldMoveUp: $isMovingUp)
                        .ignoresSafeArea()
                    
                    // MARK: - Components
                    ScrollView {
                        VStack(spacing: geo.size.height/6) {
                            WelcomeUserHeader(user: $user)
                                .frame(maxWidth: geo.size.width*0.89, maxHeight: geo.size.height*0.13)
                                .frame(width: geo.size.width)
                            
                            TextButtonContainer(
                                textExplanation: "Crie uma sala e comece\n a jogar!",
                                buttonText: "Crie uma sala",
                                buttonColor: .customYellow
                            ) {
                                withAnimation {
                                    isMovingUp = false
                                    moveImage.toggle()
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    goToCreateRoomView = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    moveImage.toggle()
                                    isMovingUp = true
                                }
                            }
                            .isStroke(true)
                            .foregroundColor(.white)
                            .padding(.bottom)
                            .offset(y: -geo.size.height*0.07)
                            .frame(height: geo.size.height*0.22)
                            
                            TextButtonContainer(
                                textExplanation: "É aluno?",
                                buttonText: "Entre em uma sala",
                                buttonColor: .blue
                            ) {
                                isMovingUp = true
                                moveImage.toggle()
                                isPopupPresented.toggle()
                                
                            }
                            .frame(width: geo.size.width*0.6, height: geo.size.height*0.17)
                            Spacer()
                        }
                        .padding(.top, 20)
                        .frame(maxWidth: geo.size.width*0.86).frame(width: geo.size.width)
                    }
                    .scrollDisabled(true)
                }
                .navigationDestination(isPresented: $goToCreateRoomView) {
                    CreateRoomView()
                }
                .navigationDestination(isPresented: $goToGameView) {
                    if let roomCode = self.roomCode {
                        GameView(host: false, roomCode: roomCode)
                    }
                }
                .navigationTitle("")
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .onAppear(perform: {
                isMovingUp = false
                moveImage = false
                isPopupPresented = false
            })
            .popupNavigationView(show: $isPopupPresented) {
                UserInputPopup(
                    isShowing: $isPopupPresented,
                    enterButtonTapped: { roomCode in
                        self.roomCode = roomCode
                        isPopupPresented = false
                        goToGameView = true
                    }
                )
                .frame(height: geo.size.height)
            }
        }
        .ignoresSafeArea(.keyboard)
        .foregroundColor(.black)
        .background(Color.offWhite)
    }
}

struct LandingScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LandingScreenView()
    }
}
