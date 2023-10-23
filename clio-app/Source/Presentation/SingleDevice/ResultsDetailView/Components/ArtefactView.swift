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
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(artefact.description)
                .font(.itimRegular(fontType: .title3))
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .padding([.trailing], 16)
            
            .frame(alignment: .bottom)
            .padding(18)
            .background(.clear)
            .overlay {
                RoundedRectangle(
                    cornerRadius: 16
                )
                .stroke(.black, lineWidth: 3)
            }
            
            if let image = UIImage(data: artefact.picture) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(
                        maxWidth: 300,
                        minHeight: 300
                    )
                    .frame(alignment: .bottom)
                    .background(.clear)
                    .overlay {
                        RoundedRectangle(
                            cornerRadius: 16
                        )
                        .stroke(.black, lineWidth: 3)
                    }
                    .padding([.bottom], 16)
            }
           
        }
    }
}

#Preview {
    ArtefactView(
        artefact: SessionArtefacts(
            picture: UIImage(systemName: "star")!.pngData()!,
            description: "A funny description for image",
            masterId: UUID()
        )
    )
}
