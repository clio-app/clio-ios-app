//
//  CreateRoomViewModel.swift
//  clio-app
//
//  Created by Thiago Henrique on 21/09/23.
//

import Foundation

final class CreateRoomViewModel: ObservableObject {
    enum ViewState: Equatable {
        case idle
        case loading
        case failed(title: String, description: String)
        case loaded(CreateRoomModel.Create.Response)
    }
    
    @Published var roomNameInput: String = ""
    @Published var roomThemeInput: String = ""
    @Published var viewState: ViewState = .idle
    
    let service: NetworkService
    
    init(service: NetworkService = NetworkService()) {
        self.service = service
    }
    
    func createRoom(request: CreateRoomModel.Create.Request) async {
        changeViewState(to: .loading)
        do {
            let endpoint = CreateRoomModel.Create.NetworkingEndpoint(body: request.encodeToTransfer())
            let value: CreateRoomModel.Create.Response = try await service.makeRequest(for: endpoint)
            changeViewState(to: .loaded(value))
        } catch {
            changeViewState(to: .failed(title: "Error!", description: error.localizedDescription))
        }
    }
    
    func changeViewState(to newState: ViewState) {
        DispatchQueue.main.async { [unowned self] in
            self.viewState = newState
        }
    }
}
