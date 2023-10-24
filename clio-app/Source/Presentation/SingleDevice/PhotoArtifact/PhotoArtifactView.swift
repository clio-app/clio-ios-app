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
    @State var presentCameraButton = false

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
                            .background {
                                cameraPlaceholder
                            }
                        
                    }
                    
                    if let _ = vm.imageData {
                        retakePhotoOverlay
                    } else if presentCameraButton {
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
            .clioBackground()
            .onAppear {
                initialConfig()
            }
            .onChange(of: vm.viewState) { newState in
                switch newState {
                case .authorized:
                    withAnimation(.easeInOut.delay(0.5)) {
                        presentCameraButton = true
                    }
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
                case .cameraError(title: let title, description: let description):
                    errorAlert = ErrorAlert(
                        showAlert: true,
                        title: title,
                        description: description
                    )
                default:
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
        }
    }
    
    func initialConfig() {
        vm.checkCameraAuthorization()
        cameraPreview = CameraPreview(vm: vm)
        theme = gameSession.getCurrentTheme()
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
    
    var cameraPlaceholder: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.black)
            Image(systemName: "camera.viewfinder")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.white)
        }
    }
    
    var takePhotoOverlay: some View {
        VStack {
            Spacer()
            CameraButton(color: .white) {
                withAnimation(.easeInOut.delay(0.3)) {
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
        .environmentObject(GameSession())
        .environmentObject(Router())
}
