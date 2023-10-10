//
//  ImagePicker.swift
//  CameraPOC
//
//  Created by Beatriz Leonel da Silva on 06/10/23.
//

import Foundation
import SwiftUI

struct CameraPicker: UIViewControllerRepresentable {
    @Binding var image: Data
    @Binding var navigateToNextView: Bool
    @Binding var showingCameraView: Bool
    typealias UIViewControllerType = UIImagePickerController
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CameraPicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = false
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: CameraPicker
        init(_ parent: CameraPicker) {
            self.parent = parent
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage.pngData() ?? Data()
                parent.navigateToNextView = true
            }
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            // TODO: Voltar para tela anterior a câmera
            parent.showingCameraView = false
        }
    }
}
