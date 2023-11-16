//
//  Router.swift
//  clio-app
//
//  Created by Luciana Adrião on 22/10/23.
//

import Foundation
import SwiftUI

enum Views: Hashable {
    case Start
    case AddPlayers
    case RaffleTheme
    case SelectPlayer
    case firstPrompt
    case PhotoArtifact
    case DescriptionArtifact
    case PresentResults
    case AllResultsVisualization
}

class Router: ObservableObject {
    @Published var path = NavigationPath()

    func clear() {
        path = .init()
    }

    func goTostartView() {
        path.append(Views.Start)
    }

    func goToPlayersView() {
        path.append(Views.AddPlayers)
    }

    func goToRaffleThemeView() {
        path.append(Views.RaffleTheme)
    }

    func goToSelectPlayer() {
        path.append(Views.SelectPlayer)
    }

    func goToCustomPrompt() {
        path.append(Views.firstPrompt)
    }

    func goToPhotoArtifactView() {
        path.append(Views.PhotoArtifact)
    }

    func goToDescriptionArtifactView() {
        path.append(Views.DescriptionArtifact)
    }
    
    func goToPresentResultsView() {
        path.append(Views.PresentResults)
    }
    
    
    func goToAllResultsVisualizationView() {
        path.append(Views.AllResultsVisualization)
    }
    
    func restartGameWithPlayers() {
        clear()
        goToPlayersView()
    }
}

enum ViewFactory {
    @ViewBuilder
    static func viewForDestination(_ destinations: Views) -> some View {
        switch destinations {
        case .Start:
            StartView()
        case .AddPlayers:
            PlayersView()
        case .RaffleTheme:
            RaffleThemeView()
        case .PhotoArtifact:
            PhotoArtifactView()
        case .SelectPlayer:
            SelectPlayerView()
        case .DescriptionArtifact:
            DescriptionArtifactView()
        case .PresentResults:
            ResultsView()
        case .firstPrompt:
            CustomFirstPrompt()
        case .AllResultsVisualization:
            AllResultsView()
        }
    }
}
