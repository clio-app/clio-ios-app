//
//  CreateRoomModel.swift
//  clio-app
//
//  Created by Thiago Henrique on 21/09/23.
//

import Foundation

enum CreateRoomModel {
    enum Create {
        struct Request: Encodable {
            let name: String
            let theme: Theme
            
            func encodeToTransfer() -> Data {
                return try! JSONEncoder().encode(self)
            }
            
            struct Theme: Encodable {
                let title: String
            }
        }
        
        struct Response: Decodable, Equatable {
            let id: String
        }
        
        struct NetworkingEndpoint: Endpoint {
            var communicationProtocol: CommunicationProtocol = .HTTP
            var urlBase: String {
                return Bundle.main.infoDictionary?["API_KEY"] as! String
            }
            var path: String = "/room/create"
            var body: Data?
            var httpMethod: HTTPMethod? = .post
            
            init(body: Data) { self.body = body }
        }
    }
}
