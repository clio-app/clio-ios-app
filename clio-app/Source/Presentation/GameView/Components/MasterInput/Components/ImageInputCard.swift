//
//  ImageCard.swift
//  clio-app
//
//  Created by Luciana Adrião on 20/09/23.
//

import SwiftUI

struct ImageInputCard: View {
    @Binding var userInputImage: UIImage
    @State private var showSheet = false

    var body: some View {
        RoundedRectangle(cornerRadius: 15.0).stroke(.black, style: StrokeStyle(lineWidth: 2.0))
            .overlay {
                Image(uiImage: userInputImage)
                    .resizable()
                // TODO: Change to fill later and add when tapped a popup with full view appear
                    .aspectRatio(contentMode: .fit)
            }
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .onTapGesture {
                showSheet.toggle()
            }
            .sheet(isPresented: $showSheet) {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: $userInputImage)
            }
    }
}
