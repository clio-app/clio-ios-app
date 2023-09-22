//
//  CreateRoomInteractor.swift
//  clio-app
//
//  Created by Thiago Henrique on 15/09/23.
//

import Foundation

protocol CreateRoomBusinessLogic {
    func createRoom(request: CreateRoom.Request)
}

final class CreateRoomInteractor: CreateRoomBusinessLogic {
    var presenter: CreateRoomPresentationLogic?
    
    func createRoom(request: CreateRoom.Request) {
        
    }
}
