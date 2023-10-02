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
            VStack (alignment: .center) {
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
                    
                    TextFieldView(
                        inputText: $inputUser,
                        placeholder: "Escreva o código",
                        color: .customPink
                    )
                    .padding(.horizontal, geo.size.width * 0.1)
                    
                    ActionButton(title: "Entre", foregroundColor: .customPink.opacity(0.5), hasBorder: false) {
                        UIApplication.shared.endEditing()
                        print(inputUser)
                    }
                    .frame(height: geo.size.height * 0.05)
                    .frame(width: geo.size.width * 0.55)
                    .padding(.horizontal, geo.size.width * 0.1)
                    .padding(.top, 50)
                    .padding(.bottom, 35)
                    
                }
                .padding()
                .background(BorderedBackground(foregroundColor: .offWhite,backgroundColor: .customPink,  hasBorder: true))
                .ignoresSafeArea(.keyboard)
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }
            }
            .keyboardAdaptive()
            .padding(.horizontal, 10)
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

struct UserInputPopup_Previews: PreviewProvider {
    static var previews: some View {
        UserInputPopup(isShowing: .constant(true))
    }
}
