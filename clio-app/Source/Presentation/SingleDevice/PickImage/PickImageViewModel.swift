//
//  PickImageViewModel.swift
//  clio-app
//
//  Created by Thiago Henrique on 10/11/23.
//

import Foundation

final class PickImageViewModel: ObservableObject {
    private var network: NetworkService
    @Published var generatedImages: [any GeneratedImage] = []
    
    init(network: NetworkService = NetworkService()) {
        self.network = network
    }
    
    @MainActor
    func generateImages() async {
        do {
            let endpoint = PickImageModel.RandomCatImages.NetworkEndpoint()
            let response: PickImageModel.RandomCatImages.Response = try await network.makeRequest(
                for: endpoint
            )
            print(response)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
