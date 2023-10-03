//
//  LobbyScreenViewModel.swift
//  clio-app
//
//  Created by Luciana Adrião on 29/09/23.
//

import Foundation

class LobbyViewModel: ObservableObject {
//    @Published var players: [User] = []
    @Published var roomName: String = ""
    private var loaded: LobbyModel.Acess.Response = .init()
    let service: NetworkService

    init(service: NetworkService = NetworkService()) {
        self.service = service
    }

//  TODO: Waiting for ws for RT player update

    // get room ID

//    func fetchRoom() async {
//        do {
//            let endpoint = LobbyModel.Acess.NetworkingEndpoint()
//            let value: LobbyModel.Acess.Response = try await service.makeRequest(for: endpoint)
//            loaded = value
//            print(loaded)
//
//        } catch {
//            print(error.localizedDescription)
//        }
//    }

    func fetchRoom() async {
        do {
            let endpoint = LobbyModel.Acess.NetworkingEndpoint()
            let responseData: LobbyModel.Acess.Response = try await service.makeRequest(for: endpoint)
            loaded = responseData

            print(loaded)
        } catch {
            print(error.localizedDescription)
        }
    }

    func change() {
        DispatchQueue.main.async {
//            self.roomName = 
        }
    }
}



// User data
struct User {
    let name: String
    let score: Int
    let userProfileImage: String
    //
    //
}
