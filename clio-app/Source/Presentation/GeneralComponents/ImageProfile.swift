//
//  ImageProfile.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 20/09/23.
//

import SwiftUI

struct ImageProfile: View {
    var body: some View {
        Circle()
            .overlay {
                Image(imageName)
                    .resizable()
                    .overlay {
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 2))
                    }
            }
    }
}

#Preview {
    ImageProfile()
}
