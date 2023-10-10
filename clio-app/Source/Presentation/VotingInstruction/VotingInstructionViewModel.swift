//
//  VotingInstructionViewModel.swift
//  clio-app
//
//  Created by Luciana Adrião on 07/10/23.
//

import Foundation
import ClioEntities

class VotingInstructionViewModel: ObservableObject {
    @Published var profiles: VotingInstructionModel.Access.Response?
    
    @Published var selectedText: ClioEntities.Description = Description(id: UUID(), userID: UUID(), text: "", voteCount: 0)

    @Published var shouldClosePopup: Bool = false

}
