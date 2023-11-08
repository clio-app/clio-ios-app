//
//  DescriptionCard.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 07/11/23.
//

import SwiftUI

struct DescriptionCard: View {
    let description: String
    
    var body: some View {
        Text(description)
            .font(.itimRegular(fontType: .title3))
            .foregroundStyle(.black)
            .multilineTextAlignment(.center)
            .lineLimit(nil)
            .padding()
            .frame(maxWidth: .infinity)
            .background {
                Color.offWhite
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay{
                        RoundedRectangle(cornerRadius: 20.0, style: .continuous)
                            .stroke(.black, lineWidth: 2.0)
                            .padding(.horizontal, 1)
                    }
            }
            .padding(.vertical, 2)
    }
}

#Preview {
    DescriptionCard(
        description: "Uma descrição muito incrível"
    )
}
