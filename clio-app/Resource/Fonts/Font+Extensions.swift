//
//  Font+Extensions.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 15/09/23.
//

import Foundation
import SwiftUI
import UIKit

extension Font {
    static func nightyDemo(size: CGFloat = 18) -> Font {
        return .custom("Nighty DEMO", size: size)
    }
    
    static func itimRegular(size: CGFloat = 18) -> Font {
        return .custom("Itim-Regular", size: size)
    }
}

extension UIFont {
    static func nightyDemo(size: CGFloat = 18) -> UIFont {
        return UIFont(name: "Nighty DEMO", size: size)!
    }
    
    static func itimRegular(size: CGFloat = 18) -> UIFont {
        return UIFont(name: "Itim-Regular", size: size)!
    }
}
