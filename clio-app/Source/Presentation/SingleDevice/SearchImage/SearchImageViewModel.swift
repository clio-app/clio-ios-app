//
//  SearchImageViewModel.swift
//  clio-app
//
//  Created by Thiago Henrique on 12/11/23.
//

import Foundation

final class SearchImageViewModel: ObservableObject {
    private var network: NetworkService
    
    @Published
    var searchedImages: SearchImageModel.Search.Response = .init(
        total: 0,
        totalHits: 0,
        hits: []
    )
    @Published
    var searchKeywords: String = String()
    
    init(network: NetworkService = NetworkService()) {
        self.network = network
    }
    
    @MainActor
    func searchImage() async {
        if searchKeywords == String() { return }
        
        do {
            let endPoint = SearchImageModel.Search.NetworkEndpoint(
                requestData: .init(keywords: searchKeywords)
            )
            let response: SearchImageModel.Search.Response = try await network.makeRequest(
                for: endPoint
            )
            searchedImages = response
        } catch {
            print(error.localizedDescription)
        }
    }

}
