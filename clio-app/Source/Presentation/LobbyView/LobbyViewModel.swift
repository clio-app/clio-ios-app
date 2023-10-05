//
//  LobbyScreenViewModel.swift
//  clio-app
//
//  Created by Luciana Adrião on 29/09/23.
//

import Foundation

class LobbyViewModel: ObservableObject {
    // TODO: String for test only, modify for UUID when updating. CreateRoom is gonna pass the roomID
    @Published var room: LobbyModel.Acess.Response.Room?

    let service: NetworkService

    init(service: NetworkService = NetworkService()) {
        self.service = service
    }

    //  TODO: Waiting for ws for RT player update
    //    func findRoom(id: String) async {
    //        do {
    //            var endpoint = LobbyModel.Acess.NetworkingEndpoint()
    //            endpoint.path.append(roomID)
    //            let responseData: LobbyModel.Acess.Response.Room = try await service.makeRequest(for: endpoint)
    //
    //        } catch {
    //            print(error.localizedDescription)
    //        }
    //    }
    func findRoom(id: String) async {
        do {
            var endpoint = LobbyModel.Acess.NetworkingEndpoint()
            endpoint.path.append(id)
            let responseData: LobbyModel.Acess.Response.Room = try await service.makeRequest(for: endpoint)
            DispatchQueue.main.async {
                self.room = responseData
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func getRoomInfo() -> (name: String, theme: String) {
        let name = room?.name ?? "NAME_NOT_FOUND"
        let theme = room?.theme.title ?? "THEME_NOT_FOUND"
        return (name, theme)
    }
}
