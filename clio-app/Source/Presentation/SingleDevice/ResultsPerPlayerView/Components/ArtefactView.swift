//
//  ArtefactView.swift
//  clio-app
//
//  Created by Thiago Henrique on 19/10/23.
//

import SwiftUI
import ClioEntities

struct ArtefactView: View {
    let artefact: SessionArtefacts
    @Binding var showZoomImage: Bool
    @Binding var showZoomDescription: Bool

    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center, spacing: 20) {
                if let imageData = artefact.picture {
                    ImageCard(imageData: imageData) 
                        .onTapGesture {
                            showZoomImage = true
                        }
                        .frame(width: geo.size.width, height: geo.size.width)
                }
                
                if let description = artefact.description {
                    DescriptionCard(description: description)
                        .onTapGesture {
                            showZoomDescription = true
                        }
                        .frame(width: geo.size.width - 4)
                }
            }
            .frame(width: geo.size.width)
            .foregroundStyle(.black)
        }
    }
}

#Preview {
    ArtefactView(
        artefact: SessionArtefacts(
            picture: UIImage(named: "liquid-bg")!.pngData()!,
            description: "A funny description for image",
            masterId: UUID()
        ), 
        showZoomImage: .constant(false),
        showZoomDescription: .constant(false)
    )
}
