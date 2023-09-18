//
//  Font+Extensions.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 15/09/23.
//

import Foundation
import SwiftUI
import UIKit



// MARK: - SwiftUI
extension Font {
    static func nightyDemo(size: CGFloat = 18) -> Font {
        return .custom("Nighty DEMO", size: size)
    }
    
    static func itimRegular(size: CGFloat = 18) -> Font {
        return .custom("Itim-Regular", size: size)
    }
}


// MARK: - UIKIT
extension UIFont {
    static func nightyDemo(size: CGFloat = 18) -> UIFont {
        return UIFont(name: "Nighty DEMO", size: size)!
    }
    
    static func itimRegular(size: CGFloat = 18) -> UIFont {
        return UIFont(name: "Itim-Regular", size: size)!
    }
}


// MARK: - Another SWIFTUI extension with pre-set sizes
extension Font {
    static func nightyDemo(fontType: FontType) -> Font {
        return .custom("Nighty Demo", size: fontType.size)
    }

    static func itimRegular(fontType: FontType) -> Font {
        return .custom("Itim-Regular", size: fontType.size)
    }

    enum FontType {
        case largeTitle
        case title3
        case body
        case button
        case headline

        var size: CGFloat {
            switch self {
            case .largeTitle:
                return 48
            case .title3:
                return 24
            case .body:
                return 20
            case .button:
                return 24
            case .headline:
                 return 24
            }
        }
    }

}
