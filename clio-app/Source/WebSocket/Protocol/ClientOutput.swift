//
//  ClientOutput.swift
//  clio-app
//
//  Created by Thiago Henrique on 09/10/23.
//

import Foundation
import ClioEntities

protocol ClientOutput: AnyObject {
    func errorWhileReceivingMessage(_ error: Error)
    func didConnectAPlayer(_ master: RoomUser, players: [RoomUser])
    func didGameStarted(_ master: RoomUser)
}
