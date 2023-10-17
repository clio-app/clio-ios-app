//
//  GameViewModel.swift
//  clio-app
//
//  Created by Thiago Henrique on 09/10/23.
//

import Foundation
import ClioEntities
import UIKit

final class GameViewModel: ObservableObject {
    enum GameState {
        case registerUser
        case waitingUsers
        case takingArtefacts(master: RoomUser, users: [RoomUser])
        case describingImage(image: Data)
        case waitingAwnsers
        case voting(descriptions: [Description])
        case gameEnd(users: [RoomUser])
    }
    
    @Published var gameState: GameState = .registerUser
    @Published var master: RoomUser?
    @Published var players: [RoomUser] = []
    @Published var isHost = false
    @Published var userIdentifier: User?
    let client = WebSocketClient.shared
    
    func connectInRoom(_ roomId: String) {
        client.connectToServer(path: "ws://127.0.0.1:8080/game/\(roomId)")
    }
    
    func registerUserInRoom(_ user: User) async {
        self.userIdentifier = user
        await client.sendMessage(
            TransferMessage(
                state: .client(.gameFlow(.registerUser)),
                data: RegisterUserinRoomDTO(user: user).encodeToTransfer()
            )
        )
    }
    
    func startGame() async {
        await client.sendMessage(
            TransferMessage(
                state: .client(.gameFlow(.gameStarted)),
                data: BooleanMessageDTO(value: true).encodeToTransfer()
            )
        )
    }
    
    func sendMasterArtefacts(picture: Data, base64: String, description: String) async {
        await client.sendMessage(
            TransferMessage(
                state: .client(.gameFlow(.masterActed)),
                data: MasterActedDTO(
                    picture: picture,
                    pictureBase64: "",
                    description: description
                ).encodeToTransfer()
            )
        )
        DispatchQueue.main.async {
            self.gameState = .waitingAwnsers
        }
    }
    
    func sendDescriptionForImage(_ description: String) async {
        guard let userIdentifier else { return }
        await client.sendMessage(
            TransferMessage(
                state: .client(.gameFlow(.userActed)),
                data: UserActedDTO(
                    userId: userIdentifier.id,
                    description: description
                ).encodeToTransfer()
            )
        )
        DispatchQueue.main.async {
            self.gameState = .waitingAwnsers
        }
    }
    
    func sendVoteToDescription(_ description: Description) async {
        guard let userIdentifier else { return }
        await client.sendMessage(
            TransferMessage(
                state: .client(.gameFlow(.userVoted)),
                data: UserVotedDTO(votedUserId: userIdentifier.id, descriptionId: description.id)
                    .encodeToTransfer()
            )
        )
        DispatchQueue.main.async {
            self.gameState = .waitingAwnsers
        }
    }
}

extension GameViewModel: ClientOutput {
    func didGameFinish(_ users: [ClioEntities.RoomUser]) {
        DispatchQueue.main.async {
            self.gameState = .gameEnd(users: users)
        }
    }
    
    func didStartVoting(_ descriptions: [Description]) {
        DispatchQueue.main.async {
            self.gameState = .voting(descriptions: descriptions)
        }
    }
    
    func didMasterShared(_ picture: Data) {
        DispatchQueue.main.async {
            self.gameState = .describingImage(image: picture)
        }
    }
    
    func didGameStarted(_ master: RoomUser) {
        DispatchQueue.main.async {
            self.gameState = .takingArtefacts(master: master, users: self.players)
        }
    }
    
    func didConnectAPlayer(_ master: RoomUser, players: [RoomUser]) {
        DispatchQueue.main.async {
            self.master = master
            self.players = players
            self.gameState = .waitingUsers
        }
    }
    
    func errorWhileReceivingMessage(_ error: Error) {
        print(error.localizedDescription)
    }
}
