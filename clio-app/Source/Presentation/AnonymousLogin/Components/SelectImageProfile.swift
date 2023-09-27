//
//  SelectImageProfile.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 21/09/23.
//

import SwiftUI

struct SelectImageProfile: View {
    
    private let imagesList = ["bonfire-picture", "circles-picture", "profile-picture-eye"]
    @Binding var selectedImage: String
    
    var action: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            
            generateUserIcon(imageName: selectedImage)
                .overlay(alignment: .bottomTrailing) {
                    randomButton()
                        .frame(width: geometry.size.width * 0.3)
                }
        }
    }
    
    private func generateUserIcon(imageName: String) -> some View {
        Circle()
            .overlay {
                Image(imageName)
                    .resizable()
                    .overlay {
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 2))
                    }
            }
    }
    
    private func randomButton() -> some View {
        Button (action: action) {
            Circle()
                .fill(Color.brick)
                .overlay {
                    Image("cross-arrow")
                        .resizable()
                        .overlay {
                            Circle()
                                .stroke(style: StrokeStyle(lineWidth: 2))
                                .foregroundColor(.black)
                        }
                }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    SelectImageProfile(selectedImage: .constant("bonfire-picture")) {
        print("OI!")
    }
}
