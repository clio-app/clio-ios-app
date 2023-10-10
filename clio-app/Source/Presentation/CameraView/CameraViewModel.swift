//
//  CameraViewModel.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 09/10/23.
//

import Foundation
import AVFoundation

final class CameraViewModel: ObservableObject {
    enum ViewState: Equatable {
        case authorized
        case denied(title: String, description: String)
        case restricted(title: String, description: String)
        case notDetermined
    }
    
    @Published var viewState: ViewState = .notDetermined
    @Published var imageData: Data = Data()
    @Published var roomTheme: String
    
    init(roomTheme: String) {
        self.roomTheme = roomTheme
    }
    
    func checkCameraAuthorization() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            requestPermission()
        case .restricted:
            changeViewState(to: ViewState.restricted(
                title: "Sem acesso à câmera!",
                description: "Não foi possível acessar a câmera! Vá nas configurações e autorize o uso da câmera para continuar!"
            ))
        case .denied:
            changeViewState(to: ViewState.restricted(
                title: "Sem acesso à câmera!",
                description: "Não foi possível acessar a câmera! Vá nas configurações e autorize o uso da câmera para continuar!"
            ))
        case .authorized:
            return
        @unknown default:
            return
        }
    }
    
    func requestPermission() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] _ in
            self?.checkCameraAuthorization()
        }
    }
    
    func changeViewState(to newState: ViewState) {
        DispatchQueue.main.async { [unowned self] in
            self.viewState = newState
        }
    }
}
