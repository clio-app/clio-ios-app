//
//  ImageCard.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 08/11/23.
//

import SwiftUI

struct ImageCard: View {
    let imageData: Data
    
    var body: some View {
        GeometryReader { geo in
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.offWhite)
                .frame(
                    width: geo.size.width,
                    height: geo.size.width
                )
                .overlay {
                    Image(uiImage: UIImage(data: imageData)!)
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: geo.size.width-2,
                            height: geo.size.width-2
                        )
                        .clipShape(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                        )
                        .allowsHitTesting(false)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20.0, style: .continuous)
                                .stroke(.black, lineWidth: 2.0)
                                .padding(.horizontal, 1)
                        }
                }
        }
        .frame(alignment: .center)
    }
}

#Preview {
    ImageCard(imageData: (UIImage(named: "AppIcon")?.pngData())!)
}
