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
                if let image = UIImage(data: artefact.picture ?? Data()) {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.offWhite)
                        .frame(
                            width: geo.size.height <= geo.size.width ? geo.size.height : geo.size.width,
                            height: geo.size.height <= geo.size.width ? geo.size.height : geo.size.width
                        )
                        .onTapGesture {
                            showZoomImage = true
                        }
                        .overlay {
                            Image(uiImage: image)
                                .resizable()
                                .frame(
                                    width: geo.size.height <= geo.size.width ? geo.size.height : geo.size.width,
                                    height: geo.size.height <= geo.size.width ? geo.size.height : geo.size.width
                                )
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                )
                                .allowsHitTesting(false)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20.0, style: .continuous)
                                        .stroke(lineWidth: 2.0)
                                        .padding(.horizontal, 1)
                                }
                        }
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
