//
//  SearchImageViewModel.swift
//  clio-app
//
//  Created by Thiago Henrique on 12/11/23.
//

import Foundation

struct PlaceholderGeneratedImage: GeneratedImage {
    var placeholder: Bool = true
    var imageUrl: URL? = nil
}

final class SearchImageViewModel: ObservableObject {
    private var network: NetworkService

    @Published
    private var currentPage: Int = 1
    
    @Published
    private var valuePerPage: Int = 16
    
    @Published
    var searchedImages: [any GeneratedImage] = []
    
    @Published
    var apiResult: SearchImageModel.Search.Response = .init(total: 0, totalHits: 0, hits: [])
    
    @Published
    var searchKeywords: String = String()
    
    init(network: NetworkService = NetworkService()) {
        self.network = network
    }
    
    @MainActor
    func searchImage() async {
        if searchKeywords == String() { return }
        createPlaceholders()
        
        do {
            let endPoint = SearchImageModel.Search.NetworkEndpoint(
                requestData: .init(
                    keywords: searchKeywords,
                    page: currentPage,
                    perPage: valuePerPage
                )
            )
            let response: SearchImageModel.Search.Response = try await network.makeRequest(
                for: endPoint
            )
            replacePlaceholders(response.hits)
            apiResult = response
            currentPage += 1
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func replacePlaceholders(_ images: [any GeneratedImage]) {
        for image in images {
            for (searchedImagesIndex, searchedImage) in searchedImages.enumerated() {
                if searchedImage.placeholder {
                    searchedImages[searchedImagesIndex] = image
                    break
                }
            }
        }
        
        searchedImages.removeAll(where: { $0.placeholder })
    }
    
    func createPlaceholders() {
        for _ in 0..<valuePerPage {
            searchedImages.append(PlaceholderGeneratedImage())
        }
    }
}
