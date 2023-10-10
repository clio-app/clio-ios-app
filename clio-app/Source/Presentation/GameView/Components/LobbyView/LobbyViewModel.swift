//
//  LobbyScreenViewModel.swift
//  clio-app
//
//  Created by Luciana Adrião on 29/09/23.
//

import Foundation
import ClioEntities

class LobbyViewModel: ObservableObject {
    @Published var currentRoom: LobbyModel.Acess.Response?
    let service: NetworkService

    init(service: NetworkService = NetworkService()) {
        self.service = service
    }

    //  TODO: Waiting for ws for RT player update
    func findRoom(id: String) async {
        do {
            var endpoint = LobbyModel.Acess.NetworkingEndpoint()
            endpoint.path.append(id)
            let responseData: LobbyModel.Acess.Response = LobbyModel.Acess.Response(
                room: try await service.makeRequest(for: endpoint)
            )
            DispatchQueue.main.async {
                self.currentRoom = responseData
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
