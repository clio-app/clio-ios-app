//
//  Client.swift
//  clio-app
//
//  Created by Thiago Henrique on 09/10/23.
//

import Foundation
import ClioEntities

protocol Client {
    var clientOutput: ClientOutput? { get set }
    
    func connectToServer(path: String)
    func disconnectToServer()
    func sendMessage(_ message: TransferMessage) async
    func handleMessageFromServer(_ message: TransferMessage, _ state: MessageState.ServerMessages)
}
