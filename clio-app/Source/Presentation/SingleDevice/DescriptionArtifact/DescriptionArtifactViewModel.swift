//
//  DescriptionArtifactViewModel.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 16/11/23.
//

import Foundation

class DescriptionArtifactViewModel: ObservableObject {
    let placeholder = NSLocalizedString("Escreva uma descrição sobre a imagem...", comment: "write a description for the image")
    var theme = ""
    let maxWordCount: Int = 100
    
    @Published var showSelectEmoji = false
    @Published var selectedIndex: Int?
    
    let imagePlaceHolder: Data
    @Published var uiImageData: Data?
    
    @Published var input = ""

    @Published var showZoomImage = false
    
    init(imagePlaceHolder: Data) {
        self.imagePlaceHolder = imagePlaceHolder
    }
    
    func initialSetUp(theme: String, imageData: Data?) {
        self.theme = theme
        if let data = imageData {
            uiImageData = data
        }
    }
    
    func verifyInput() {
        if input == "" {
            input = placeholder
        }
    }
    
    func canSendDescription() -> Bool {
        if input == placeholder {
            return false
        }
        if input == "" {
            return false
        }
        if input.count > maxWordCount {
            return false
        }
        return true
    }
}
