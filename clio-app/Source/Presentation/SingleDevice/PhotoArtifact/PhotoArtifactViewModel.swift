//
//  PhotoArtifactViewModel.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 18/10/23.
//

import Foundation
import AVFoundation

final class PhotoArtifactViewModel: NSObject, ObservableObject {
    enum ViewState: Equatable {
        case authorized
        case denied(title: String, description: String)
        case restricted(title: String, description: String)
        case notDetermined
        case cameraError(title: String, description: String)
    }
    
    @Published var viewState: ViewState!
    @Published var preview: AVCaptureVideoPreviewLayer!
    @Published var imageData: Data?
    
    var captureSession = AVCaptureSession()
    private let output = AVCapturePhotoOutput()
    
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
            changeViewState(to: .authorized)
            setup()
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
    
    func setup() {
        do {
            captureSession.beginConfiguration()
            
            guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
                changeViewState(to: .cameraError(title: "Erro na Câmera!", description: "Reinicie o aplicativo! Caso o problema permaneça entre em contato."))
                return
            }
            
            let input = try AVCaptureDeviceInput(device: videoDevice)
            
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
            
            if captureSession.canAddOutput(output) {
                captureSession.addOutput(output)
            }
            
            captureSession.commitConfiguration()
            
        } catch {
            changeViewState(to: .cameraError(title: "Erro na Câmera!", description: "Reinicie o aplicativo! Caso o problema permaneça entre em contato."))
        }
    }
    
    func cameraToggle() {
        if captureSession.isRunning {
            DispatchQueue.main.async {
                self.captureSession.stopRunning()
            }
        } else {
            DispatchQueue.main.async {
                self.imageData = nil
            }
            DispatchQueue.global(qos: .background).async {
                self.captureSession.startRunning()
            }
        }
    }
    
    func takePhoto() {
        self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
}

extension PhotoArtifactViewModel: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let capturedPhoto = photo.fileDataRepresentation() else { return }
        self.imageData = capturedPhoto
        self.cameraToggle()
    }
}
