//
//  clio_appApp.swift
//  clio-app
//
//  Created by Thiago Henrique on 15/09/23.
//

import SwiftUI

@main
struct clio_appApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
//            SearchImageView(keywords: "Arvores")
//            PickImageView()
            StartView()
                .preferredColorScheme(.light)
        }
    }
}

