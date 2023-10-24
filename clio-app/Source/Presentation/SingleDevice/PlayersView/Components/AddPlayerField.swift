//
//  AddPlayerField.swift
//  clio-app
//
//  Created by Luciana Adrião on 24/10/23.
//

import SwiftUI

struct AddPlayerField: View {
    @Binding var color: String
    @Binding var playerName: String

    var onAddPlayer: (() -> Void)
    var onChangeImage: (() -> Void)

    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 45, alignment: .center)
                .applyColor(color)
                .onTapGesture {
                    onChangeImage()
                }

            TextField(text: $playerName) {
                Text("Nome do jogador...")
                    .foregroundColor(.black.opacity(0.6))
                    .font(.itimRegular(fontType: .body))
            }
            .textFieldStyle(PlainTextFieldStyle())
            .padding(6)
            .foregroundColor(.black)
            .submitLabel(.done)
            .onSubmit {
                onAddPlayer()
            }
        }
        .padding(12)
        .background(Color.white)
        .overlay {
            RoundedRectangle(cornerRadius: 20.0, style: .continuous)
            .stroke(lineWidth: 2.0)
        }
    }
}
