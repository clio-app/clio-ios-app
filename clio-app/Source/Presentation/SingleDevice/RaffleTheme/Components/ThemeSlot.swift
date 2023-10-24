//
//  ThemeSlot.swift
//  clio-app
//
//  Created by Luciana Adrião on 24/10/23.
//

import SwiftUI

struct themeSlot: View {
    @Binding var theme: String

    var body: some View {
        Text(theme)
            .font(.nightyDemo(fontType: .largeTitle))
    }
}

