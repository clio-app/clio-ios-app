//
//  VotingInstructionModel.swift
//  clio-app
//
//  Created by Luciana Adrião on 07/10/23.
//

import Foundation
import ClioEntities

class VotingInstructionModel {
    enum Access {
        struct Request: Encodable {}
        
        // Object:UpdatePlayersRoomDTO
        struct Response: Decodable, Equatable {
            let users: [ClioEntities.RoomUser]
            let master: ClioEntities.RoomUser
        }
    }

}
