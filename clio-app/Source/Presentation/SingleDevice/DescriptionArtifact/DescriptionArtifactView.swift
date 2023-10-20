//
//  DescriptionArtifactView.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 19/10/23.
//

import SwiftUI

struct DescriptionArtifactView: View {
    @EnvironmentObject var session: GameSession
    
    @State var theme = ""
    @State var uiImage = UIImage(systemName: "photo.on.rectangle.angled")!
    @State var input = ""
    
    @State var showZoomImage = false
    @State var navigateToNextView = false
    
    private let maxWordCount: Int = 100
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    ThemeCard(theme: $theme)
                        .frame(width: geo.size.width * 0.8)
                        .background{
                            BorderedBackground(
                                foregroundColor: .white,
                                hasBorder: false
                            )
                        }
                        .padding(.vertical)
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.white)
                            .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.42)
                            .onTapGesture {
                                withAnimation {
                                    UIApplication.shared.endEditing()
                                    showZoomImage = true
                                }
                            }
                            .overlay {
                                image
                                    .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.42)
                                    .clipped()
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                                    .allowsHitTesting(false)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(.black, lineWidth: 2)
                                    }
                            }
                        
                        LimitedInputTextField(maxInputCount: 100, inputUser: $input)
                            .foregroundColor(.black)
                            .frame(width: geo.size.width * 0.7, height: geo.size.height * 0.15)
                    }
                    
                    Spacer()
                    Spacer()
                    
                    button
                        .frame(width: geo.size.width * 0.8, height: 60)
                        .padding(.bottom)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
            .keyboardAdaptive()
            .toolbar(.hidden, for: .navigationBar)
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            .overlay {
                if showZoomImage {
                    ZoomImage(selectedImage: $showZoomImage, uiImage: $uiImage)
                }
            }
            .onAppear {
                theme = session.gameFlowParameters.sessionTheme
                if let data = session.getLastImage() {
                    uiImage = UIImage(data: data)!
                }
            }
            .navigationDestination(isPresented: $navigateToNextView) {
                VStack {
                    Text("Tela da câmera")
                    Text((session.gameFlowParameters.currenPlayer?.artefact?.description) ?? "")
                }
            }
            .background {
                Color.white.ignoresSafeArea()
            }
        }
        .ignoresSafeArea(.keyboard)
        .environmentObject(GameSession())
        .navigationTitle("")
    }
}

extension DescriptionArtifactView {
    
    var image: some View {
        ZStack {
            if uiImage == UIImage(systemName: "photo.on.rectangle.angled") {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 80)
            } else {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            
        }
    }
    
    var button: some View {
        ActionButton(
            title: "Próximo",
            foregroundColor: .customYellow,
            backgroundColor: .white,
            hasBorder: true) {
                UIApplication.shared.endEditing()
                session.sendDescription(description: input)
                navigateToNextView = true
            }
            .disabled(input.count > maxWordCount)
            .disabled(input == "")
            .opacity(input == "" ? 0.2 : 1)
    }
}

#Preview {
    DescriptionArtifactView()
}