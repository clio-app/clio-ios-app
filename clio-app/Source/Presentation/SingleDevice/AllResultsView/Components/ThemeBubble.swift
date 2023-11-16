//
//  ThemeBubble.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 13/11/23.
//

import SwiftUI

struct ThemeBubble: View {
    let theme: String

    var body: some View {
        VStack {
            Text("O tema é:")
                .font(.itimRegular(fontType: .body))

            Text(theme)
                .font(.itimRegular(fontType: .largeTitle))
        }
        .multilineTextAlignment(.center)
        .padding(24)
        .background(RoundedRectangle(cornerRadius: 20, style: .continuous).foregroundColor(.white))
        .overlay {
            RoundedRectangle(cornerRadius: 20.0, style: .continuous)
            .stroke(lineWidth: 2.0)
        }
        .foregroundColor(.black)
    }
}

#Preview {
    ThemeBubble(theme: "Geografia")
}
