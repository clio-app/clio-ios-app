//
//  ImageCard.swift
//  clio-app
//
//  Created by Luciana Adrião on 20/09/23.
//

import SwiftUI

struct ImageInputCard: View {
    @Binding var userInputImage: String

    var body: some View {
        RoundedRectangle(cornerRadius: 15.0).stroke(.black, style: StrokeStyle(lineWidth: 2.0))
            .overlay {
                Image(userInputImage)
                    .resizable()
                // TODO: Change to fill later and add when tapped a popup with full view appear
                    .aspectRatio(contentMode: .fit)
            }
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    ImageInputCard(userInputImage: .constant(""))
}
