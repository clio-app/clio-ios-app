//
//  ImagePlaceholder.swift
//  clio-app
//
//  Created by Thiago Henrique on 14/11/23.
//

import SwiftUI

struct ImagePlaceholder: View {
    var body: some View {
        Rectangle()
            .foregroundStyle(.clear)
            .overlay {
                RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                .stroke(Color.gray, style: .init(lineWidth: 2))
                .foregroundStyle(.clear)
                .overlay {
                    Image(systemName: "photo.fill.on.rectangle.fill")
                    .resizable()
                    .foregroundStyle(.gray)
                    .aspectRatio(contentMode: .fill)
                    .padding(42)
                }
            }
    }
}

#Preview {
    ImagePlaceholder()
}
