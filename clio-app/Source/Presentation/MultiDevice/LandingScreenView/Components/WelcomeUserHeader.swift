//
//  CreateRoomComponents.swift
//  clio-app
//
//  Created by Luciana Adrião on 17/09/23.
//

import SwiftUI

struct WelcomeUserHeader: View {
    @Binding var user: String
    @ScaledMetric(relativeTo: .largeTitle) var paddingWidth = 14.5
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2.0) {
                Text("Olá,").font(.itimRegular(fontType: .title3))
                Text(user).font(.nightyDemo(fontType: .largeTitle)).truncationMode(.tail)

            }
            Spacer()
            Circle()
                .overlay {
                    Image("profile-picture-eye")
                        .resizable()
                        .background(Circle().fill(Color.offWhite))
                        .overlay {
                            Circle().stroke(style: StrokeStyle(lineWidth: 2.0))
                        }
                }
        }

        .padding(EdgeInsets(top: 16, leading: 36, bottom: 16, trailing: 31))
        .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
        .foregroundColor(.offWhite))
        .overlay {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .stroke(style: StrokeStyle(lineWidth: 2.0))
        }
        .foregroundColor(.black)
    }
}

struct CreateRoomComponents_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeUserHeader(user: .constant("Luciana"))
    }
}


