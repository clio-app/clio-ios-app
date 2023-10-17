//
//  clio_appApp.swift
//  clio-app
//
//  Created by Thiago Henrique on 15/09/23.
//

import SwiftUI

@main
struct clio_appApp: App {
    @Environment(\.scenePhase) var scenePhase
    var sceneHandler = ApplicationSceneHandler()
    
    var body: some Scene {
        WindowGroup {
            LandingScreenView()
                .onChange(of: scenePhase, perform: sceneHandler.handle)
//            CreateRoomView()
//            LobbyView()
        }
    }
}

class ApplicationSceneHandler {
    func handle(_ scene: ScenePhase) {
        switch scene {
            case .background:
                print("BACKGROUND")
            case .inactive:
                print("INACTIVE")
            case .active:
                print("ACTIVE")
            @unknown default:
                break
        }
    }
}
