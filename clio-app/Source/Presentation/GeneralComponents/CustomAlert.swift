//
//  CustomAlert.swift
//  clio-app
//
//  Created by Luciana Adrião on 24/10/23.
//

import SwiftUI

struct CustomAlert: View {
    @Binding var isPopupPresented: Bool
    let title: String
    let text: String

    var body: some View {
        VStack(alignment: .center) {
            Text(LocalizedStringKey(title))
                .font(.nightyDemo(fontType: .largeTitle))


            Text(LocalizedStringKey(text))
                .font(.itimRegular(fontType: .body))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
                .padding(.vertical, 36)

            ActionButton(title: "Okay", foregroundColor: Color.lapisLazuli, hasBorder: false) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isPopupPresented.toggle()
                }
            }
            .frame(maxHeight: 42)
            .padding(.horizontal, 42)
        }
        .foregroundColor(.black)
        .padding(.vertical, 36)
        .background(BorderedBackground(foregroundColor: Color.offWhite, backgroundColor: Color.lapisLazuli, hasBorder: true))
    }
}

