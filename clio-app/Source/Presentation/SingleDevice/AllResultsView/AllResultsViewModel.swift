//
//  AllResultsViewModel.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 13/11/23.
//

import Foundation

class AllResultsViewModel: ObservableObject {
    enum ViewState: Equatable {
        case presentTheme
        case presentArtifacts
    }
    
    @Published private(set) var state: ViewState = .presentTheme
    @Published var showZoomImage: Bool = false
    @Published var selectedImage: Data?
    
    
    func changeState() {
        state = .presentArtifacts
    }
}
