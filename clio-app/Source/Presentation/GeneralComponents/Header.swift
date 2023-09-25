//
//  Header.swift
//  clio-app
//
//  Created by Luciana Adrião on 20/09/23.
//

import SwiftUI

struct Header: View {

    // userList and masterUser receives and shows profile picture name
    @Binding var userList: [String]
    @Binding var masterUser: String

    var body: some View {
        HStack(alignment: .center, spacing: 24) {
            VStack(alignment: .leading) {
                Text("Turma A").font(.nightyDemo(fontType: .largeTitle))
                Text("1ª Guerra Mundial").font(.itimRegular(fontType: .title3))
            }
            .lineLimit(1)
            .foregroundStyle(Color.black).truncationMode(.tail)
//            .fixedSize(horizontal: false, vertical: true)

            RadialUsers(usersList: $userList, masterUser: $masterUser)
                .padding(.all, 24)
        }
        .padding(EdgeInsets(top: 28, leading: 17, bottom: 15, trailing: 15))
        .overlay {
            RoundedRectangle(cornerRadius: 15, style: .continuous).stroke(style: StrokeStyle(lineWidth: 2.0))
                .fill(.black)
        }
    }
}

#Preview {
    Header(userList: .constant(["User 1", "User 2", "User 3", "User 4", "User 5", "User 6", "User 7"]), masterUser: .constant("Professor"))
}
