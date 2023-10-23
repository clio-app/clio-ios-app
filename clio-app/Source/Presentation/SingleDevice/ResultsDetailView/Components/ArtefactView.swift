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
        Text(artefact.description)
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
