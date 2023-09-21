//
//  CreateRoomViewModel.swift
//  clio-app
//
//  Created by Thiago Henrique on 21/09/23.
//

import Foundation

final class CreateRoomViewModel: ObservableObject {
    @Published var roomNameInput: String = ""
    @Published var roomThemeInput: String = ""
    let service: NetworkService
    
    init(service: NetworkService = NetworkService()) {
        self.service = service
    }
    
    func createRoom(request: CreateRoomModel.Create.Request) async {
        do {
            let endpoint = CreateRoomModel.Create.NetworkingEndpoint(body: request.encodeToTransfer())
            let value: CreateRoomModel.Create.Response = try await service.makeRequest(for: endpoint)
            print(value)
        } catch {
            print(error.localizedDescription)
        }
    }
}
