//
//  ZoomDescriptionCard.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 07/11/23.
//

import SwiftUI

struct ZoomDescriptionCard: View {
    @Binding var showZoomDescription: Bool
    let description: String
    @State var scale  = 0.0
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .transition(.opacity)
            
            DescriptionCard(description: description)
                .padding(.horizontal)
                .transition(.scale)
                .scaleEffect(scale)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.25)) {
                scale = 1.0
            }
        }
        .onTapGesture {
            dismissZoom()
        }
    }
    
    func dismissZoom() {
        withAnimation(.easeInOut(duration: 0.15)) {
            scale = 0.0
            showZoomDescription = false
        }
    }
}

#Preview {
    @State var showZoomDescription = false
    
    var view = ZoomDescriptionCard(
        showZoomDescription: $showZoomDescription,
        description: "Uma descrição muito top. Essa descrição é extraordinariamente incrível e maravilhosa!")
    
    return view
}
