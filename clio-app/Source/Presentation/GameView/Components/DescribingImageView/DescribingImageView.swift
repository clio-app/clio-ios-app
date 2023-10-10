//
//  DescribingImageView.swift
//  clio-app
//
//  Created by Thiago Henrique on 10/10/23.
//

import SwiftUI

struct DescribingImageView: View {
    @EnvironmentObject var gameViewModel: GameViewModel
    @State private var description: String = String()
    let imageData: Data
    
    var body: some View {
        VStack {
            Image(uiImage: UIImage(data: imageData) ?? UIImage())
                .resizable()
                .frame(width: 250, height: 60)
            
            TextFieldView(inputText: $description, placeholder: "", color: .blue)
            
            Button("Enviar") {
                if description != "" {
                    Task {
                        await gameViewModel.sendDescriptionForImage(description)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}
