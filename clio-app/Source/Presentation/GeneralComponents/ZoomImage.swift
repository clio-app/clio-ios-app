//
//  ZoomIMage.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 19/10/23.
//

import SwiftUI

struct ZoomImage: View {

    @Binding var selectedImage: Bool
    let uiImage: UIImage
    @State var scale = 0.0

    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()

            VStack {
                imageSection(uiImage: uiImage)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeInOut(duration: 0.25)) {
                scale = 1.0
            }
        }
        .onTapGesture {
            dismissZoom()
        }
    }
}

extension ZoomImage {

    private func imageSection(uiImage: UIImage) -> some View {
        return(
            TabView {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .overlay {
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(.black, lineWidth: 2)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .clipped()
                    .background {
                        Color.offWhite
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                    }
                    .padding(.horizontal)
            }
                .frame(height: UIDevice.current.userInterfaceIdiom == .pad ? nil : 500)
                .padding([.vertical], 100)
                .scaleEffect(scale)
                .tabViewStyle(.page)
        )
    }
    
    func dismissZoom() {
        withAnimation(.easeInOut(duration: 0.15)) {
            scale = 0.0
            selectedImage = false
        }
    }
}

#Preview {
    ZoomImage(
        selectedImage: .constant(true),
        uiImage: UIImage(named: "magnifier-rose") ?? UIImage(systemName: "photo.on.rectangle.angle")!
    )
}
