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
            }
            .font(.itimRegular(fontType: .body))
            .textFieldStyle(PlainTextFieldStyle())
            .padding(6)
            .foregroundColor(.black)
            .submitLabel(.done)
            .onSubmit {
                onAddPlayer()
            }
            
            Image(systemName: "checkmark.circle")
                .resizable()
                .scaledToFit()
                .symbolRenderingMode(.multicolor)
                .frame(width: 30, alignment: .centerFirstTextBaseline)
                .onTapGesture{
                    onAddPlayer()
                }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 14)
        .background(
            Color.white
                .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
        )
        .overlay {
            RoundedRectangle(cornerRadius: 20.0, style: .continuous)
            .stroke(lineWidth: 2.0)
        }
    }
}
