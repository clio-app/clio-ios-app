//
//  CreateRoomModels.swift
//  clio-app
//
//  Created by Thiago Henrique on 21/09/23.
//

import Foundation

enum CreateRoom {
    struct Request {
        let name: String
        let theme: String
    }
    
    struct Response {
        let roomCode: String
    }
    
    struct ViewModel {
        let roomCode: String
    }
}
