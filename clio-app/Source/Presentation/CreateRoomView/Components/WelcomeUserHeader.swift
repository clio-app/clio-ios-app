//
//  CreateRoomComponents.swift
//  clio-app
//
//  Created by Luciana Adrião on 17/09/23.
//

import SwiftUI

struct WelcomeUserHeader: View {
    @Binding var user: String
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Olá,").font(.itimRegular(size: 24))
                Text(user).font(.nightyDemo(fontType: .largeTitle)).truncationMode(.tail)
            }
            Spacer(minLength: 50)
            Circle().stroke(style: StrokeStyle(lineWidth: 2.0)).frame(width: 60, height: 60)

        }

        .padding(EdgeInsets(top: 16, leading: 36, bottom: 16, trailing: 31))
        .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                .foregroundColor(.offWhite))
        .overlay {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .stroke(style: StrokeStyle(lineWidth: 2.0))
        }
    }
}

struct CreateRoomComponents_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeUserHeader(user: .constant("Luciana"))
    }
}


