//
//  RoundedBorder.swift
//  clio-app
//
//  Created by Thiago Henrique on 14/11/23.
//

import SwiftUI

struct RoundedBorder: View {
    let size: CGSize
    
    var body: some View {
        RoundedRectangle(cornerSize: size)
            .stroke(Color.gray, style: .init(lineWidth: 2))
            .foregroundStyle(.clear)
    }
}

#Preview {
    RoundedBorder(size: CGSize(width: 30, height: 30))
}
