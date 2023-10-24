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
            if let description = artefact.description {
                Text(description)
                    .font(.itimRegular(fontType: .title3))
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .padding([.trailing], 16)
                    .frame(alignment: .bottom)
                    .padding(18)
                    .background(RoundedRectangle(cornerRadius: 20, style: .continuous).foregroundColor(.white))
                    .overlay {
                        RoundedRectangle(cornerRadius: 20.0, style: .continuous)
                            .stroke(lineWidth: 2.0)
                    }
            }

            if let image = UIImage(data: artefact.picture ?? Data()) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(
                        maxWidth: 300,
                        minHeight: 300
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .frame(alignment: .bottom)
                    .background(RoundedRectangle(cornerRadius: 20, style: .continuous).foregroundColor(.offWhite))
                    .overlay {
                        RoundedRectangle(cornerRadius: 20.0, style: .continuous)
                            .stroke(lineWidth: 2.0)
                    }
                    .padding([.bottom], 16)
            }
        }
        .foregroundStyle(.black)
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
