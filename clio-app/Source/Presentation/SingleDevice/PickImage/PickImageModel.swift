//
//  PickImageModel.swift
//  clio-app
//
//  Created by Thiago Henrique on 10/11/23.
//

import Foundation

protocol GeneratedImage: Identifiable {
    var id: UUID { get }
    var imageUrl: URL { get }
}

extension GeneratedImage {
    var id: UUID {
        return UUID()
    }
}

enum PickImageModel {
    enum RandomCatImages {
        struct Request {}
        
        struct Response: Decodable {
            let images: [CatImage]
            
            struct CatImage: Decodable, GeneratedImage {
                let id: String
                let url: String
                let width, height: Int
                
                var imageUrl: URL {
                    return URL(string: url)!
                }
            }
        }
        
        struct NetworkEndpoint: Endpoint {
            var body: Data?
            var httpMethod: HTTPMethod? = .get
            var communicationProtocol: CommunicationProtocol = .HTTPS
            var urlBase: String = "api.thecatapi.com"
            var path: String = "v1/images/search"
            var queries: [URLQueryItem] = [.init(name: "limit", value: "10")]
        }
    }
}
