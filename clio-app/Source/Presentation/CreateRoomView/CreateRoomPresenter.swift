//
//  CreateRoomPresenter.swift
//  clio-app
//
//  Created by Thiago Henrique on 15/09/23.
//

import Foundation

protocol CreateRoomPresentationLogic {
    func presentRoomCode(request: CreateRoom.Response)
}

class CreateRoomPresenter: CreateRoomPresentationLogic {
    var view: CreateRoomDisplayLogic?
    
    func presentRoomCode(request: CreateRoom.Response) {
        
    }
}
