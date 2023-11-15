//
//  PickImageViewModel.swift
//  clio-app
//
//  Created by Thiago Henrique on 10/11/23.
//

import Foundation

final class PickImageViewModel: ObservableObject {
    private var network: NetworkService
    
    @Published
    var generatedImages: [PickImageModel.RandomCatImages.Response.CatImage] = [
        PickImageModel.RandomCatImages.Response.CatImage(id: "0", url: "", width: 0, height: 0),
        PickImageModel.RandomCatImages.Response.CatImage(id: "0", url: "", width: 0, height: 0),
        PickImageModel.RandomCatImages.Response.CatImage(id: "0", url: "", width: 0, height: 0),
        PickImageModel.RandomCatImages.Response.CatImage(id: "0", url: "", width: 0, height: 0),
        PickImageModel.RandomCatImages.Response.CatImage(id: "0", url: "", width: 0, height: 0),
        PickImageModel.RandomCatImages.Response.CatImage(id: "0", url: "", width: 0, height: 0)
    ]
    
    @Published
    var showSearchImagePopUp = false
    
    @Published
    var goToSearchResultView = false
    
    @Published
    var showHighlightedImagePopup = false
    
    @Published
    var searchKeywords: String = String()
    
    @Published
    var selectedImage: PickImageModel.RandomCatImages.Response.CatImage?
    
    @Published
    var highlightedImage: PickImageModel.RandomCatImages.Response.CatImage?
        
    init(network: NetworkService = NetworkService()) { self.network = network }
    
    @MainActor
    func generateImages() async {
        do {
            let endpoint = PickImageModel.RandomCatImages.NetworkEndpoint()
            let response: [PickImageModel.RandomCatImages.Response.CatImage] = try await network.makeRequest(
                for: endpoint
            )
            generatedImages.removeAll()
            self.generatedImages.append(contentsOf: response)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
