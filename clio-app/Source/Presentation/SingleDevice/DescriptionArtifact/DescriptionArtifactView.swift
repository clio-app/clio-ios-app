//
//  DescriptionArtifactView.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 19/10/23.
//

import SwiftUI
import Mixpanel

struct DescriptionArtifactView: View {
    @EnvironmentObject var session: GameSession
    @EnvironmentObject var router: Router
    @ObservedObject var vm = DescriptionArtifactViewModel(imagePlaceHolder: UIImage(systemName: "photo.on.rectangle.angled")!.pngData()!)

    @State private var startArtifactDescriptionTimer: DispatchTime!

    var body: some View {
        GeometryReader { geo in
            ScrollViewReader { proxy in
                ScrollView {
                    VStack {
                        ThemeCard(
                            title: "Relacione a foto com o tema:",
                            theme: $vm.theme
                        )
                        .frame(width: geo.size.width * 0.8)
                        .background{
                            BorderedBackground(
                                foregroundColor: .white,
                                hasBorder: false
                            )
                        }
                        .padding(.top, 5)
                        .padding(.bottom)
                            
                        Spacer()
                        
                        VStack(spacing: 20) {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.white)
                                .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.42)
                                .onTapGesture {
                                    withAnimation {
                                        UIApplication.shared.endEditing()
                                        vm.showZoomImage = true
                                    }
                                }
                                .overlay {
                                    image
                                        .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.45)
                                        .clipped()
                                        .clipShape(RoundedRectangle(cornerRadius: 30))
                                        .allowsHitTesting(false)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 30)
                                                .stroke(.black, lineWidth: 2)
                                        }
                                }
                                .overlay {
                                    VStack {
                                        Spacer()
                                        ReactionButton(
                                            showSelectEmoji: $vm.showSelectEmoji,
                                            selectedIndex: $vm.selectedIndex
                                        )
                                            .frame(width: geo.size.width * 0.7, height: geo.size.height * 0.09)
                                            .offset(x: -5, y: geo.size.height * 0.1/3.5)
                                    }
                                    .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.45, alignment: .trailing)
                                }
                            
                            LimitedInputTextField(
                                maxInputCount: vm.maxWordCount,
                                inputUser: $vm.input,
                                placeholder: vm.placeholder,
                                secondaryAction: {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                        withAnimation {
                                            proxy.scrollTo("buttons")
                                            hideEmojis()
                                        }
                                    }
                                }
                            )
                            .frame(
                                width: geo.size.width * 0.8,
                                height: geo.size.height * 0.15
                            )
                            .padding(.top, geo.size.height * 0.1 / 3)
                        }
                        
                        Spacer()
                        Spacer()
                        
                        button
                            .id("buttons")
                            .frame(width: geo.size.width * 0.8, height: 60)
                            .padding(.bottom)
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
            }
            .keyboardAdaptive()
            .onTapGesture {
                UIApplication.shared.endEditing()
                hideEmojis()
                vm.verifyInput()
            }
            .onAppear {
                startArtifactDescriptionTimer = .now()
                vm.initialSetUp(
                    theme: session.gameFlowParameters.sessionTheme,
                    imageData: session.getLastImage()
                )
            }
        }
        .applyHelpButton(.DescriptionArtifact)
        .clioBackground()
        .overlay {
            if vm.showZoomImage {
                ZoomImage(
                    selectedImage: $vm.showZoomImage,
                    uiImage: UIImage(data: vm.uiImageData ?? vm.imagePlaceHolder)!
                )
                .onAppear {
                    hideEmojis()
                }
            }
        }
        .ignoresSafeArea(.keyboard)
        .environmentObject(session)
        .navigationTitle("")
        .navigationBarBackButtonHidden()
    }
    
    func hideEmojis() {
        withAnimation {
            vm.showSelectEmoji = false
        }
    }
}

extension DescriptionArtifactView {
    
    var image: some View {
        ZStack {
            if let imageData = vm.uiImageData {
                Image(uiImage: UIImage(data: imageData)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Image(uiImage: UIImage(data: vm.imagePlaceHolder)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 80)
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
                let endArtifactDescriptionTimer: DispatchTime = .now()
                let artifactDescriptionTimerElapsedTime = Double(
                    endArtifactDescriptionTimer.uptimeNanoseconds -
                    startArtifactDescriptionTimer.uptimeNanoseconds
                ) / 1_000_000_000
                
                Mixpanel.mainInstance().track(
                    event: "Descriptions Artifact",
                    properties: [
                        "Elapsed Description Time": artifactDescriptionTimerElapsedTime
                    ]
                )
                
                session.sendArtifact(description: vm.input)

                switch session.gameState {
                case .final:
                    router.goToPresentResultsView()
                default:
                    router.goToPhotoArtifactView()
                }
            }
            .disabled(!vm.canSendDescription())
            .opacity((!vm.canSendDescription()) ? 0.2 : 1)
    }
}

#Preview {
    DescriptionArtifactView()
        .environmentObject(GameSession())
        .environmentObject(Router())
}
