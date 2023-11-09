//
//  ResultsDetailViewModel.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 07/11/23.
//

import Foundation

class ResultsDetailViewModel: NSObject, ObservableObject {
    enum ViewState: Equatable {
        case showTheme
        case presentFirstArtifact
        case presentMiddleArtifacts
        case presentLastArtifact
    }
    
    @Published var state: ViewState = .showTheme
    
    @Published var currentInteraction = 0
    
    @Published var showZoomImage = false
    @Published var showZoomDescription = false
    
    func changeState(newState: ViewState) {
        self.state = newState
    }
    
    func checkNextState(_ newValue: Int, _ limit: Int) -> ViewState {
        if newValue == limit {
            return .presentLastArtifact
        } else if newValue == 0 {
            return .presentFirstArtifact
        }
        return .presentMiddleArtifacts
    }
}
