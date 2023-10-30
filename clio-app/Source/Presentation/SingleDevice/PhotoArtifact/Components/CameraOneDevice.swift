//
//  CameraOneDevice.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 30/10/23.
//

import SwiftUI

struct CameraOneDevice: View {
    let takePhotoAction: () -> Void
    let retakePhotoAction: () -> Void
    
    @Binding var imageData: Data?
    @Binding var presentCameraButton: Bool
    @Binding var cameraPreview: CameraPreview?
    
    var body: some View {
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
            if let _ = imageData {
                retakePhotoOverlay
            } else if presentCameraButton {
                takePhotoOverlay
            }
            
        }
    }
}

extension CameraOneDevice {
    var takePhotoOverlay: some View {
        VStack {
            Spacer()
            CameraButton(color: .white) {
                takePhotoAction()
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
                retakePhotoAction()
            }
            .frame(width: 70, height: 70)
            .padding(.bottom, 20)
            .transition(.opacity)
        }
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
}

#Preview {
    CameraOneDevice(
        takePhotoAction: {print("Take photo")},
        retakePhotoAction: {print("Retake photo")},
        imageData: .constant(Data()),
        presentCameraButton: .constant(false),
        cameraPreview: .constant(CameraPreview(vm: .init())))
}
