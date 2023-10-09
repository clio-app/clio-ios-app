//
//  AnonymousLoginViewModel.swift
//  clio-app
//
//  Created by Thiago Henrique on 09/10/23.
//

import Foundation

final class AnonymousLoginViewModel: ObservableObject {
    
    func connectInRoom(_ roomId: String) {
        let client = WebSocketClient.shared
        client.connectToServer(path: "ws://127.0.0.1:8080/game/\(roomId)") { success in
            
        }
    }
}
