//
//  LobbyScreenViewModel.swift
//  clio-app
//
//  Created by Luciana Adrião on 29/09/23.
//

import Foundation
import ClioEntities

class LobbyViewModel: ObservableObject {
    var players: [RoomUser] = [
        RoomUser(rankingPosition: 3, points: 4, didVote: true, user: User(id: UUID(), name: "", picture: "")),
        RoomUser(rankingPosition: 1, points: 2, didVote: false, user: User(id: UUID(), name: "", picture: ""))
    ]

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
            let responseData: LobbyModel.Acess.Response = LobbyModel.Acess.Response(room: try await service.makeRequest(for: endpoint))
            DispatchQueue.main.async {
                self.currentRoom = responseData
            }
        } catch {
            print(error.localizedDescription)
        }
    }



    
}

