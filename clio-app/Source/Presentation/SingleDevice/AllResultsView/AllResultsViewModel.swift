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
    
    enum AnswerType: Equatable {
        case image
        case description
    }
    
    @Published private(set) var state: ViewState = .presentTheme
    @Published var showZoomImage: Bool = false
    @Published var selectedImage: Data?
    
    @Published var currentLastIndex = 0
    @Published var currentAnswer: AnswerType = .image
    var lastIndex: Int = 3
    
    func changeState() {
        state = .presentArtifacts
    }
    
    func isFinished() -> Bool {
        if lastIndex == currentLastIndex {
            return true
        }
        return false
    }
    
    func addAnswer() {
        switch currentAnswer {
        case .image:
            currentLastIndex += 1
            if currentLastIndex > lastIndex {
                currentLastIndex = lastIndex
            }
            currentAnswer = .description
        case .description:
            currentAnswer = .image
        }
        print(currentAnswer)
        print(currentLastIndex)
    }
    
    func isToShowImageFor(index: Int) -> Bool {
        return (index != currentLastIndex || currentAnswer == .image)
    }
    
    func set(size: Int) {
        lastIndex = size - 1

    }
}
