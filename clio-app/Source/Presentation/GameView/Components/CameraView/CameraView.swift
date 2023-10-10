//
//  ContentView.swift
//  CameraPOC
//
//  Created by Beatriz Leonel da Silva on 06/10/23.
//

import SwiftUI

struct CameraView: View {
    @EnvironmentObject var gameViewModel: GameViewModel
    
    @ObservedObject var vm: CameraViewModel
    @Binding var navigateToNextView: Bool
    
    @State var showingCameraView = true {
        didSet {
            if !showingCameraView {
                DispatchQueue.main.async {
                    gameViewModel.gameState = .waitingUsers
                }
            }
        }
    }
    @State private var errorAlert: ErrorAlert = ErrorAlert.initialState()
        
    var body: some View {
        NavigationStack {
            ZStack {
                CameraPicker(
                    image: $gameViewModel.imageData,
                    navigateToNextView: $navigateToNextView
                ) {
                    showingCameraView = false
                }
                .ignoresSafeArea()
                HintOverlay(theme: $vm.roomTheme)
            }
        }
        .onAppear {
            vm.checkCameraAuthorization()
        }
        .alert(isPresented: $errorAlert.showAlert) {
            Alert(
                title: Text(errorAlert.title),
                message: Text(errorAlert.description),
                dismissButton: Alert.Button.cancel(Text("OK"))
            )
        }
        .onChange(of: vm.viewState) { state in
            switch state {
            case .authorized:
                return
            case let .denied(title, description):
                errorAlert = ErrorAlert(
                    showAlert: true,
                    title: title,
                    description: description
                )
            case let .restricted(title, description):
                errorAlert = ErrorAlert(
                    showAlert: true,
                    title: title,
                    description: description
                )
            case .notDetermined:
                return
            }
        }
    }
}


#Preview {
    CameraView(vm: .init(roomTheme: "Guerra Fria"),  navigateToNextView: .constant(false))
}
