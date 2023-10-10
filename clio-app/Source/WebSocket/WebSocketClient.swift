//
//  WebSocketClient.swift
//  clio-app
//
//  Created by Thiago Henrique on 09/10/23.
//

import Foundation
import ClioEntities

final class WebSocketClient: NSObject, Client {
    private(set) var opened: Bool = false
    private(set) var webSocket: URLSessionWebSocketTask?
    static let shared = WebSocketClient()
    lazy var session: URLSession = URLSession(
        configuration: .default,
        delegate: self,
        delegateQueue: nil
    )

    weak var clientOutput: ClientOutput?
    
    func connectToServer(path: String) {
        if !opened { openWebSocket(URL(string: path)!) }
        guard let webSocket = webSocket else { return }
        
        webSocket.receive(
            completionHandler: { [weak self] result in
                switch result {
                case .failure(_):
                    self?.opened = false
                    return
                case .success(let message):
                    self?.decodeServerMessage(message)
                }
                self?.connectToServer(path: path)
            }
        )
    }
    
    private func openWebSocket(_ baseURL: URL) {
        let request = URLRequest(url: baseURL)
        webSocket  = session.webSocketTask(with: request)
        opened = true
        webSocket?.resume()
    }
    
    private func decodeServerMessage(_ serverMessage: URLSessionWebSocketTask.Message) {
        switch serverMessage {
            case .data(let data):
                do {
                    let message = try JSONDecoder().decode(TransferMessage.self, from: data)
                    handleMessage(message)
                } catch {
                    clientOutput?.errorWhileReceivingMessage(error)
                }
            default:
                break
            }
    }
    
    func disconnectToServer() {
        
    }
    
    func sendMessage(_ message: TransferMessage) async {
        guard let webSocket = webSocket else { return }
        let encondedData = try! JSONEncoder().encode(message)
        webSocket.send(URLSessionWebSocketTask.Message.data(encondedData)) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }

    }
    
    func handleMessage(_ message: TransferMessage) {
        switch message.state {
            case .client(_):
                break
            case .server(let serverMessage):
                handleMessageFromServer(message, serverMessage)
        }
    }
    
    func handleMessageFromServer(_ message: TransferMessage, _ state: MessageState.ServerMessages) {
        switch state {
            case .connection(let connectionMessage):
                handleWithConnectionMessage(message, connectionMessage)
            case .gameFlow(let gameFlowMessage):
                handleWithGameflowMessage(message, gameFlowMessage)
            case .error:
                break
        }
    }
    
    func handleWithConnectionMessage(
        _ message: TransferMessage,
        _ state: MessageState.ServerMessages.ServerConnection
    ) {
        switch state {
            case .playerConnected:
                let dto = UpdatePlayersRoomDTO.decodeFromMessage(message.data)
                clientOutput?.didConnectAPlayer(dto.master, players: dto.users)
        }
    }
    
    func handleWithGameflowMessage(
        _ message: TransferMessage,
        _ state: MessageState.ServerMessages.ServerGameFlow
    ) {
        switch state {
            case .masterActing:
                let dto = MasterActingDTO.decodeFromMessage(message.data)
                clientOutput?.didGameStarted(dto.master)
            case .masterSharing:
                let dto = MasterSharingDTO.decodeFromMessage(message.data)
                clientOutput?.didMasterShared(dto.picture)
            case .userDidAct:
                let _ = UserDidActDTO.decodeFromMessage(message.data)
                break
            case .startVoting:
                let dto = StartVotingDTO.decodeFromMessage(message.data)
                clientOutput?.didStartVoting(dto.descriptions)
            case .userDidVote:
                let dto = UserDidVoteDTO.decodeFromMessage(message.data)
                print("\(state): \(dto)")
                break
            case .roundEnd:
                let dto = RoundEndDTO.decodeFromMessage(message.data)
                clientOutput?.didGameFinish(dto.ranking)
                print("\(state): \(dto)")
                break
        }
    }
}

extension WebSocketClient: URLSessionDelegate {}
