//
//  PhotoArtifactView.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 18/10/23.
//

import SwiftUI
import Mixpanel

struct PhotoArtifactView: View {
    @EnvironmentObject var gameSession: GameSession
    @EnvironmentObject var router: Router

    @StateObject var vm: PhotoArtifactViewModel = PhotoArtifactViewModel()
    @State private var errorAlert: ErrorAlert = .initialState()

    @State private var startArtifactPhotoTimer: DispatchTime!
    @State var cameraPreview: CameraPreview?
    @State var presentCameraButton = false


    var body: some View {
        GeometryReader { geo in
            VStack {
                ThemeCardOneDevice(theme: vm.theme)
                    .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.2)
                    .background{ BorderedBackground(foregroundColor: .white, hasBorder: false)}
                    .padding(.vertical)
                
                
                CameraOneDevice(
                    takePhotoAction: {
                        withAnimation(.easeInOut.delay(0.3)) {
                            vm.takePhoto()
                        }},
                    retakePhotoAction: {
                        withAnimation {
                            vm.cameraToggle()
                        }},
                    imageData: $vm.imageData,
                    presentCameraButton: $presentCameraButton,
                    cameraPreview: $cameraPreview
                )
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
                            saveElapsedTime()
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
            .navigationTitle("")
            .navigationBarBackButtonHidden()
            .frame(width: geo.size.width, height: geo.size.height)
            .clioBackground()
            .onAppear {
                initialConfig()                
                startArtifactPhotoTimer = .now()
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
        .applyHelpButton(.PhotoArtifact)
    }
    
    func initialConfig() {
        vm.checkCameraAuthorization()
        cameraPreview = CameraPreview(vm: vm)
        vm.theme = gameSession.getCurrentTheme()
    }
    
    func saveElapsedTime() {
        let endArtifactPhotoTimer: DispatchTime = .now()
        let artifactPhotoTimerElapsedTime = Double(
            endArtifactPhotoTimer.uptimeNanoseconds -
            startArtifactPhotoTimer.uptimeNanoseconds
        ) / 1_000_000_000
        
        Mixpanel.mainInstance().track(
            event: "Photo Artifact",
            properties: [
                "Elapsed Photo Time": artifactPhotoTimerElapsedTime
            ]
        )
    }
}

#Preview {
    PhotoArtifactView()
        .environmentObject(GameSession())
        .environmentObject(Router())
}
