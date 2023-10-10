//
//  AnonymousLoginViewModel.swift
//  clio-app
//
//  Created by Thiago Henrique on 09/10/23.
//

import Foundation
import ClioEntities

final class AnonymousLoginViewModel: ObservableObject {
    private(set) var imagesList = ["bonfire-picture", "circles-picture", "profile-picture-eye"]
    @Published var masterImage: String = "circles-picture"
    @Published var usersImages: [String] = []
    @Published var userName: String = String()
    @Published var currentRoom: AnonymousLoginModel.Acess.Response?
    @Published var currentImage: String {
        didSet {
            if usersImages.isEmpty {
                masterImage = currentImage
            }
            else {
                let lastIndex = usersImages.count - 1
                usersImages[lastIndex] = currentImage
            }
        }
    }
    let service: NetworkService

    init(service: NetworkService = NetworkService(), masterImage: String? = nil, usersImages: [String] = []) {
        self.service = service
        if let masterImage = masterImage {
            self.masterImage = masterImage
            self.usersImages = usersImages + ["bonfire-picture"]
            self.currentImage = "bonfire-picture"
        } else {
            self.masterImage = "profile-picture-eye"
            self.currentImage = "profile-picture-eye"
            self.usersImages = usersImages
        }
    }
    
    func createUser() async -> User? {
        do {
            let request = AnonymousLoginModel.CreateUser.Request(name: userName, picture: currentImage)
            let endpoint = AnonymousLoginModel.CreateUser.NetworkingEndpoint(body: request.encodeToTransfer())
            let value: AnonymousLoginModel.CreateUser.Response = AnonymousLoginModel.CreateUser.Response(
                user: try await service.makeRequest(for: endpoint)
            )
            return value.user
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func findRoom(id: String) async {
        do {
            var endpoint = LobbyModel.Acess.NetworkingEndpoint()
            endpoint.path.append(id)
            let responseData: AnonymousLoginModel.Acess.Response = AnonymousLoginModel.Acess.Response(
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
