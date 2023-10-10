//
//  GameViewModel.swift
//  clio-app
//
//  Created by Thiago Henrique on 09/10/23.
//

import Foundation
import ClioEntities

final class GameViewModel: ObservableObject {
    enum GameState {
        case registerUser
        case waitingUsers
        case takingArtefacts(master: RoomUser, users: [RoomUser])
        case describingImage
        case waitingAwnsers
    }
    
    @Published var gameState: GameState = .registerUser
    @Published var master: RoomUser?
    @Published var players: [RoomUser] = []
    let client = WebSocketClient.shared
    
    func connectInRoom(_ roomId: String) {
        client.connectToServer(path: "ws://127.0.0.1:8080/game/\(roomId)")
    }
    
    func registerUserInRoom(_ user: User) async {
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
}

extension GameViewModel: ClientOutput {
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
        
    }
}