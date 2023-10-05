//
//  LobbyModel.swift
//  clio-app
//
//  Created by Luciana Adrião on 29/09/23.
//

import Foundation

enum LobbyModel {
    
    enum Acess {
//         sent to the API. 
//        It conforms to the Encodable protocol, which means you can convert instances of this struct to JSON data using the encodeToTransfer method.
        struct Request: Encodable { }

//         The Response struct represents the data that your app expects to receive from the API after a successful action. 
//        Conforms to the Decodable protocol, which means it can be initialized from JSON data.
        struct Response: Decodable, Equatable {
            struct Room: Equatable, Decodable {
                let master: String?
                let password: String?
                let id: String
                let participants: [String?]
                let gameStarted: Bool
                let theme: Theme
                let createdBy: String?
                let name: String
            }
            
            struct Theme: Decodable, Equatable {
                let title: String
            }
        }

        struct NetworkingEndpoint: Endpoint {
            var communicationProtocol: CommunicationProtocol = .HTTP
            var urlBase: String {
                return "127.0.0.1:8080"
            }
            var path: String = "/room/"
            var body: Data?
            var httpMethod: HTTPMethod? = .get
        }
    }
}

