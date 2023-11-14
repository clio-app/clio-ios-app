//
//  SearchImageView.swift
//  clio-app
//
//  Created by Thiago Henrique on 12/11/23.
//

import SwiftUI

struct SearchImageView: View {
    @StateObject private var vm = SearchImageViewModel()
    let keywords: String
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("Imagens geradas")
                    .lineLimit(nil)
                    .font(.itimRegular(fontType: .headline))
                    .multilineTextAlignment(.center)
                    .frame(width: geo.size.width, height: 70)
                
                ScrollView {
                    LazyVGrid(
                        columns: [
                            GridItem(.fixed(geo.size.height * 0.22)),
                            GridItem(.fixed(geo.size.height * 0.22))
                        ],
                        spacing: 42
                    ) {
                        ForEach((0..<vm.searchedImages.count), id: \.self) { index in
                            AsyncImage(url: vm.searchedImages[index].imageUrl) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .frame(width: geo.size.width * 0.4, height: 110)
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(
                                            .rect(
                                                cornerSize: CGSize(
                                                    width: 30,
                                                    height: 30
                                                )
                                            )
                                        )
                                } else {
                                    ImagePlaceholder()
                                        .frame(width: geo.size.width * 0.4, height: 110)
                                }
                            }
                        }
                    }
                }
                .padding([.top], 32)
                
                Spacer()
                
                ActionButton(
                    title: "Enviar",
                    foregroundColor: .blue,
                    backgroundColor: .white,
                    hasBorder: true,
                    action: {}
                )
                .frame(maxHeight: 42)
                .padding(.horizontal, 36)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .onAppear {
            vm.searchKeywords = keywords
            Task { await vm.searchImage() }
        }
    }
}

#Preview {
    SearchImageView(keywords: "Arvore")
}
