//
//  AppDelegate.swift
//  clio-app
//
//  Created by Thiago Henrique on 24/10/23.
//

import Foundation
import UIKit
import Mixpanel

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        let mixPanelToken = Bundle.main.infoDictionary?["MIXPANEL_TOKEN"] as! String
        Mixpanel.initialize(token: mixPanelToken, trackAutomaticEvents: true)
        
        return true
    }
}
