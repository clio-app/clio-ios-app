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
    
    @Published var selectedText: ClioEntities.Description = Description(id: UUID(), userID: UUID(), text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus eu justo in ligula accumsan fermentum. Nulla facilisi. Curabitur interdum, libero eget consectetur tincidunt, metus augue varius velit, a rhoncus lectus urna eu risus.", voteCount: 0)

    @Published var shouldClosePopup: Bool = false

}
