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
    @Binding var isShowing: Bool

    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center, spacing: 18) {
                HStack {
                    Spacer()
                    Button(action: {
                        // Dismiss self
                        isShowing.toggle()

                    }, label: {
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.black, Color.peach)
                            .overlay {
                                Circle().stroke(.black)
                            }
                    })
                }

                Text("Entrar").font(.nightyDemo(fontType: .largeTitle))
                Text("Digite o código da sala:").font(.itimRegular(fontType: .title3))
                TextField("Escreva o código", text: $inputUser).font(.itimRegular(fontType: .body)).padding(.leading, 14.0)
                    .frame(width: geo.size.width * 0.81, height: geo.size.height * 0.12)
                .background(BorderedBackground(foregroundColor: .offWhite, backgroundColor: .customPink, hasBorder: true))

                ActionButton(title: "Entre", foregroundColor: .customPink, hasBorder: false) {
                    print(inputUser)
                }
                .frame(height: geo.size.height * 0.10).padding(.horizontal, 70)
                .padding(.top, 63)
                .padding(.bottom, 35)

            }
            .padding()
            .background(BorderedBackground(foregroundColor: .offWhite,backgroundColor: .customPink,  hasBorder: true))
            .ignoresSafeArea(.keyboard)
        }
    }
}

struct UserInputPopup_Previews: PreviewProvider {
    static var previews: some View {
        UserInputPopup(isShowing: .constant(true))
    }
}
