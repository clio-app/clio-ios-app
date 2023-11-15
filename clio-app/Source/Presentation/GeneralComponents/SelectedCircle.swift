//
//  SelectedCircle.swift
//  clio-app
//
//  Created by Thiago Henrique on 14/11/23.
//

import SwiftUI

struct SelectedCircle: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Circle()
                Image(systemName: "checkmark")
                    .resizable()
                    .frame(
                        width: geo.size.width * 0.7,
                        height: geo.size.width * 0.7
                    )
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.black)
                    .padding(12)
            }
            .foregroundStyle(Color.lapisLazuli)
            .overlay {
                Circle()
                    .stroke(lineWidth: 4)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

#Preview {
    SelectedCircle()
        .frame(
            width: 32,
            height: 18
        )
}
