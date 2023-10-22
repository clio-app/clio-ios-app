//
//  PhotoArtifactView.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 18/10/23.
//

import SwiftUI

struct PhotoArtifactView: View {
    @EnvironmentObject var gameSession: GameSession
    @EnvironmentObject var router: Router

    @StateObject var vm: PhotoArtifactViewModel = PhotoArtifactViewModel()
    @State private var errorAlert: ErrorAlert = .initialState()
    
    @State var cameraPreview: CameraPreview?
    @State var theme: String = ""
    
    @State var navigateToNextView = false
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                themeCard
                    .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.2)
                    .background{
                        BorderedBackground(foregroundColor: .white, hasBorder: false)
                    }
                    .padding(.vertical)
                
                
                ZStack {
                    if let camera = cameraPreview {
                        camera
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.black, lineWidth: 2)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                    }
                    
                    if let _ = vm.imageData {
                        retakePhotoOverlay
                    } else {
                        takePhotoOverlay
                    }
                    
                }
                .frame(
                    width: geo.size.width * 0.8,
                    height: geo.size.height * 0.6
                )
                
                Spacer()
                
                ActionButton(
                    title: "Enviar",
                    foregroundColor: .lapisLazuli,
                    backgroundColor: .white, hasBorder: true) {
                        if let data = vm.imageData {
                            gameSession.sendArtifact(picture: data)
                        }
                        navigateToNextView = true
                        router.goToSelectPlayer()
                    }
                    .disabled(vm.imageData == nil)
                    .opacity(vm.imageData == nil ? 0.2 : 1)
                    .frame(
                        width: geo.size.width * 0.8,
                        height : 60
                    )
                    .padding(.bottom)

            }
            .toolbar(.hidden, for: .navigationBar)
            .frame(width: geo.size.width, height: geo.size.height)
            .background{Color.white.ignoresSafeArea()}
            .onAppear {
                vm.checkCameraAuthorization()
                cameraPreview = CameraPreview(vm: vm)
                
                // TODO: Modify theme according to the round
                theme = gameSession.getCurrentTheme()
            }
            .onChange(of: vm.viewState) { newState in
                switch newState {
                case .authorized:
                    return
                case .denied(title: let title, description: let description):
                    errorAlert = ErrorAlert(
                        showAlert: true,
                        title: title,
                        description: description
                    )
                case .restricted(title: let title, description: let description):
                    errorAlert = ErrorAlert(
                        showAlert: true,
                        title: title,
                        description: description
                    )
                case .notDetermined:
                    return
                case .cameraError(title: let title, description: let description):
                    errorAlert = ErrorAlert(
                        showAlert: true,
                        title: title,
                        description: description
                    )
                case .none:
                    return
                }
            }
            .alert(isPresented: $errorAlert.showAlert) {
                Alert(
                    title: Text(errorAlert.title),
                    message: Text(errorAlert.description),
                    dismissButton: .cancel(Text("OK"))
                )
            }
            .environmentObject(gameSession)
            
        }
    }
}

extension PhotoArtifactView {
    var themeCard: some View {
        Group {
            Text("Tire uma foto que se relacione com:")
                .foregroundColor(.black)
                .font(.itimRegular(size: 18))
            + Text("\n \(theme)")
                .foregroundColor(.lapisLazuli)
                .font(.itimRegular(size: 20))
        }
        .multilineTextAlignment(.center)
        .padding()
    }
    
    var takePhotoOverlay: some View {
        VStack {
            Spacer()
            CameraButton(color: .white) {
                withAnimation {
                    vm.takePhoto()
                }
            }
            .frame(width: 70, height: 70)
            .padding(.bottom, 20)
            .transition(.opacity)
        }
    }
    
    var retakePhotoOverlay: some View {
        VStack {
            Spacer()
            RetakePhotoButton(backgroundColor: .white, fontColor: .black) {
                withAnimation {
                    vm.cameraToggle()
                }
            }
            .frame(width: 70, height: 70)
            .padding(.bottom, 20)
            .transition(.opacity)
        }
    }
}

#Preview {
    PhotoArtifactView()
}
