//
//  CameraPlaceholder.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 30/11/23.
//

import SwiftUI

struct CameraPlaceholder: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.black)
            Image(systemName: "camera.viewfinder")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    CameraPlaceholder()
}
