//
//  PickImageView.swift
//  clio-app
//
//  Created by Thiago Henrique on 10/11/23.
//

import SwiftUI

struct PickImageView: View {
    @StateObject private var vm = PickImageViewModel()
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("Generate Image Action Description")
                    .font(.itimRegular(fontType: .body))
                    .multilineTextAlignment(.center)
                
                ActionButton(
                    title: "Search Image By Theme Button",
                    foregroundColor: .yellow,
                    hasBorder: false,
                    action: {}
                )
                .frame(
                    width: geo.size.width * 0.55,
                    height: 42
                )
                .padding(.horizontal, 56)
                .padding(.bottom, 12)
                
                Text("Generated Images Label")
                    .lineLimit(nil)
                    .font(.itimRegular(fontType: .headline))
                    .multilineTextAlignment(.center)
                    .frame(
                        width: geo.size.width * 0.85,
                        height: 70
                    )
                    
                LazyVGrid(
                    columns: [
                        GridItem(.fixed(geo.size.height * 0.22)),
                        GridItem(.fixed(geo.size.height * 0.22))
                    ],
                    spacing: 42
                ) {
                    ForEach((0..<vm.generatedImages.count), id: \.self) { imageIndex in
                        AsyncImage(url: vm.generatedImages[imageIndex].imageUrl) { phase in
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
                                    Rectangle()
                                        .foregroundStyle(.clear)
                                        .frame(
                                            width: geo.size.width * 0.4,
                                            height: 110
                                        )
                                        .overlay {
                                            RoundedRectangle(
                                                cornerSize: CGSize(
                                                    width: 30, 
                                                    height: 30
                                                )
                                            )
                                            .stroke(
                                                Color.gray,
                                                style: .init(lineWidth: 2)
                                            )
                                            .foregroundStyle(.clear)
                                            .overlay {
                                                Image(
                                                    systemName: "photo.fill.on.rectangle.fill"
                                                )
                                                .resizable()
                                                .foregroundStyle(.gray)
                                                .aspectRatio(contentMode: .fill)
                                                .padding(42)
                                            }
                                            .shimmer()
                                        }
                                }
                        }
                    }
                }
                .frame(
                    width: geo.size.width * 0.9,
                    height: geo.size.height * 0.6
                )
                .clipped()
                
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
            .frame(
                width: geo.size.width,
                height: geo.size.height
            )
        }
        .onAppear {
            Task {
                await vm.generateImages()
            }
        }
    }
    
    func loadImage(from phase: AsyncImagePhase) -> Image {
        return phase.image != nil ? phase.image! :
            Image(systemName: "photo.fill.on.rectangle.fill")
        
        
    }
}

#Preview {
    PickImageView()
}
