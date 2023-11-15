//
//  PickImageViewModel.swift
//  clio-app
//
//  Created by Thiago Henrique on 10/11/23.
//

import Foundation

final class PickImageViewModel: ObservableObject {
    private var network: NetworkService
    private var valuesPerPage = 6
    
    @Published
    var generatedImages: [any GeneratedImage] = []
    
    @Published
    var showSearchImagePopUp = false
    
    @Published
    var showHighlightedImagePopup = false
    
    @Published
    var searchKeywords: String = String()
    
    @Published
    var selectedImage: (any GeneratedImage)?
    
    @Published
    var highlightedImage: (any GeneratedImage)?
        
    init(network: NetworkService = NetworkService()) { self.network = network }
    
    @MainActor
    func generateImages() async {
        createPlaceholders()
        
        do {
            let endpoint = PickImageModel.RandomCatImages.NetworkEndpoint()
            let response: [PickImageModel.RandomCatImages.Response.CatImage] = try await network.makeRequest(
                for: endpoint
            )
            replacePlaceholders(response)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func replacePlaceholders(_ images: [any GeneratedImage]) {
        for image in images {
            for (searchedImagesIndex, searchedImage) in generatedImages.enumerated() {
                if searchedImage.placeholder {
                    generatedImages[searchedImagesIndex] = image
                    break
                }
            }
        }
        
        generatedImages.removeAll(where: { $0.placeholder })
    }
    
    func createPlaceholders() {
        for _ in 0..<valuesPerPage {
            generatedImages.append(PlaceholderGeneratedImage())
        }
    }
    
}
