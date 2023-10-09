//
//  AnonymousLoginModel.swift
//  clio-app
//
//  Created by Thiago Henrique on 09/10/23.
//

import Foundation
import ClioEntities

enum AnonymousLoginModel {
    enum CreateUser {
        struct Request: Encodable {
            let name: String
            let picture: String
            
            func encodeToTransfer() -> Data {
                return try! JSONEncoder().encode(self)
            }
        }
        
        struct Response: Decodable {
            let user: User
        }
        
        struct NetworkingEndpoint: Endpoint {
            var communicationProtocol: CommunicationProtocol = .HTTP
            var urlBase: String { return "127.0.0.1:8080" }
            var path: String = "/user/create"
            var body: Data?
            var httpMethod: HTTPMethod? = .post
        }
    }
}
