//
//  UserInputPopup.swift
//  clio-app
//
//  Created by Luciana Adrião on 18/09/23.
//

import SwiftUI

// TODO: Finish the popup

struct UserInputPopup: View {
    @State var inputUser: String = ""

    var body: some View {
        TextField("Escreva o código", text: $inputUser)
            .padding()
            .background(BorderedBackground(foregroundColor: .brick, backgroundColor: .yellow, hasBorder: true))
    }
}

struct UserInputPopup_Previews: PreviewProvider {
    static var previews: some View {
        UserInputPopup()
    }
}
