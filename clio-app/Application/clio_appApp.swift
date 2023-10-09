//
//  clio_appApp.swift
//  clio-app
//
//  Created by Thiago Henrique on 15/09/23.
//

import SwiftUI

@main
struct clio_appApp: App {
    var body: some Scene {
        WindowGroup {
            CameraView(vm: .init(roomTheme: "Guerra Fria"), showingCameraView: .constant(true))
        }
    }
}
