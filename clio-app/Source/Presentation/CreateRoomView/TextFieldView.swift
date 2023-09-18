//
//  TextFieldView.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 18/09/23.
//

import SwiftUI

struct TextFieldView: View {
    
    @Binding var inputText: String
    let placeholder: String
    let color: UIColor
    
    var body: some View {
        ZStack {
            TextField(
                "",
                text: $inputText,
                prompt: Text(placeholder)
                    .font(.itimRegular())
                    .foregroundColor(.gray))
            .font(.itimRegular())
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background { Color.white }
            .cornerRadius(16)
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.black, lineWidth: 2)
            }
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(UIColor.lapisLazuli))
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.black, lineWidth: 2)
                    }
                    .offset(x: 5, y: 7)
            }
        }
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        @State var input: String = ""
        TextFieldView(inputText: $input, placeholder: "PlaceHolder", color: .lapisLazuli)
    }
}
