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
    @State private var isCreatingNewRoom: Bool = false

    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                ZStack {
                    Color.white
                        .ignoresSafeArea()
                    
                    // MARK: - Background
                    Background(shouldAnimate: $moveImage, animationDuration: .constant(0.5), shouldMoveUp: $isMovingUp)
                        .ignoresSafeArea(.keyboard)
                    
                    // MARK: - Components
                    VStack(spacing: geo.size.height/6) {
                        WelcomeUserHeader(user: $user)
                            .frame(maxWidth: geo.size.width*0.89, maxHeight: geo.size.height*0.13)
                            .frame(width: geo.size.width)
                        
                        ZStack {
                            NavigationLink(
                                destination: CreateRoomView(),
                                isActive: $isCreatingNewRoom
                            ) { }
                            
                            TextButtonContainer(textExplanation: "Crie uma sala e comece a jogar", buttonText: "Crie uma sala", buttonColor: .customYellow ) {
                                withAnimation {
                                    isMovingUp = false
                                    moveImage.toggle()
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                    isCreatingNewRoom = true
                                    isMovingUp = true
                                    moveImage.toggle()
                                }
                            }
                            .frame(height: geo.size.height*0.17)
                        }
                        
                        TextButtonContainer(textExplanation: "É aluno?", buttonText: "Entre em uma sala", buttonColor: .blue) {
                            isMovingUp = true
                            moveImage.toggle()
                            isPopupPresented.toggle()
                            
                        }
                        .frame(width: geo.size.width*0.6, height: geo.size.height*0.17)
                        Spacer()
                    }.frame(maxWidth: geo.size.width*0.86).frame(width: geo.size.width)
                        .navigationTitle("")
                }
            }
            .onAppear(perform: {
                isMovingUp = false
                moveImage = false
                isPopupPresented = false
            })

            .popupNavigationView(show: $isPopupPresented) {
                UserInputPopup(isShowing: $isPopupPresented)
            }
        }
        .foregroundColor(.black)
        .background(Color.offWhite)
    }
}

struct LandingScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LandingScreenView()
    }
}
