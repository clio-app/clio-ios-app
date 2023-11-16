//
//  PickImageModel.swift
//  clio-app
//
//  Created by Thiago Henrique on 10/11/23.
//

import Foundation

enum PickImageModel {
    enum Search {
        struct Request: Codable {
            let keywords: String
        }
        
        struct Response: Decodable, Identifiable {
            var id: UUID = UUID()
            let total: Int
            let totalHits: Int
            let hits: [PixabayModel]
            
            private enum CodingKeys: String, CodingKey {
                case total, totalHits, hits
            }
            
            struct PixabayModel: Decodable {
                let id: Int
                let pageURL: String
                let type, tags: String
                let previewURL: String
                let previewWidth, previewHeight: Int
                let webformatURL: String
                let webformatWidth, webformatHeight: Int
                let largeImageURL: String
                let imageWidth, imageHeight, imageSize, views: Int
                let downloads, collections, likes, comments: Int
                let userID: Int
                let user: String
                let userImageURL: String

                enum CodingKeys: String, CodingKey {
                    case id, pageURL, type, tags, previewURL, previewWidth, previewHeight, webformatURL, webformatWidth, webformatHeight, largeImageURL, imageWidth, imageHeight, imageSize, views, downloads, collections, likes, comments
                    case userID = "user_id"
                    case user, userImageURL
                }
            }
        }
        
        struct NetworkEndpoint: Endpoint {
            var body: Data? = nil
            var httpMethod: HTTPMethod? = .get
            var communicationProtocol: CommunicationProtocol = .HTTPS
            var requestData: PickImageModel.Search.Request
            var urlBase: String {
                return "pixabay.com/"
            }
            
            var queries: [URLQueryItem] {
                return [
                    .init(
                        name: "key",
                        value: Bundle.main.infoDictionary?["PIXABAY_API_KEY"] as? String
                    ),
                    .init(name: "q", value: requestData.keywords),
                    .init(name: "image_type", value: "photo")
                ]
            }
            
            var path: String {
                return "api/"
            }
            
            init(requestData: PickImageModel.Search.Request) {
                self.requestData = requestData
            }
        }
    }
}
