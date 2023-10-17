//
//  MasterInputViewModel.swift
//  clio-app
//
//  Created by Thiago Henrique on 12/10/23.
//

import Foundation
import UIKit

final class MasterInputViewModel: ObservableObject {
    let networkService: Network
    
    init(networkService: Network = NetworkService()) {
        self.networkService = networkService
    }
    
    func sendImage(roomCode: String, image: UIImage) async  {
        do {
            var data = Data()
            let inputImage = UIImage(named: "AppIcon")!
            let boundary = UUID().uuidString
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"\(roomCode)\"; filename=\"\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
            data.append(inputImage.pngData()!)

            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
            let endPoint = MasterInputNetworkEndpoint(roomCode: roomCode, body: data)
            let response: String = try await networkService.makeRequest(for: endPoint)
            print(response)
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct MasterInputNetworkEndpoint: Endpoint {
    let roomCode: String
    var communicationProtocol: CommunicationProtocol = .HTTP
    var httpMethod: HTTPMethod? = .post
    var body: Data?
    var headers: [String : String] = ["Content-Type": "multipart/form-data"]
    var urlBase: String = "127.0.0.1:8080"
    var path: String {
        return "/game/\(roomCode)/image"
    }
    
    init(roomCode: String, body: Data?) {
        self.roomCode = roomCode
        self.body = body
    }
}
