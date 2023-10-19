//
//  CameraPreview.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 18/10/23.
//

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    @ObservedObject var vm: PhotoArtifactViewModel
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        let preview = AVCaptureVideoPreviewLayer(session: vm.captureSession)
        preview.frame = view.frame
        preview.videoGravity = .resizeAspectFill
        
        view.layer.addSublayer(preview)
        
        DispatchQueue.main.async {
            vm.preview = preview
        }
        
        vm.cameraToggle()
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {  }
}

