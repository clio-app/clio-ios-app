//
//  SelectPlayerViewModel.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 19/10/23.
//

import Foundation
import ClioEntities

final class SelectPlayerViewModel: ObservableObject {
    
    enum ViewState: Equatable {
        case confirmation
        case findingPlayer
    }
    
    @Published var currentPlayer: User?
    @Published var viewState: ViewState = .findingPlayer
    
    func changeViewState(to newState: ViewState) {
        DispatchQueue.main.async { [unowned self] in
            self.viewState = newState
        }
    }
    
    func changePlayer(newPlayer: User?) {
        currentPlayer = newPlayer
        if currentPlayer != nil {
            changeViewState(to: .confirmation)
        }
    }
}
