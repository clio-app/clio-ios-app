//
//  Header.swift
//  clio-app
//
//  Created by Luciana Adrião on 20/09/23.
//

import SwiftUI

struct Header: View {
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            VStack(alignment: .leading) {
                Text("Turma A").font(.nightyDemo(fontType: .largeTitle))
                Text("1ª Guerra Mundial").font(.itimRegular(fontType: .title3))
            }.foregroundStyle(Color.black)
            
             // TODO: Add Radial Participants Component
            Image("profile-picture-eye").scaledToFit()
        }
        .padding(EdgeInsets(top: 28, leading: 17, bottom: 15, trailing: 15))
        .overlay {
            RoundedRectangle(cornerRadius: 15, style: .continuous).stroke(style: StrokeStyle(lineWidth: 2.0))
                .fill(.black)
        }
    }
}

#Preview {
    Header()
}
