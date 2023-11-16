//
//  PickImageView.swift
//  clio-app
//
//  Created by Thiago Henrique on 10/11/23.
//

import SwiftUI

struct PickImageView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var session: GameSession
    @StateObject private var vm = PickImageViewModel()
    private let layout = PickImageViewLayout()
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("Generate Image Action Description")
                    .font(.itimRegular(fontType: .body))
                    .multilineTextAlignment(.center)
                    .padding([.top], 16)
                
                ActionButton(
                    title: "Search Image By Theme Button",
                    foregroundColor: .yellow,
                    hasBorder: false,
                    action: { vm.showSearchImagePopUp.toggle() }
                )
                .frame(width: geo.size.width * 0.55, height: 42)
                .padding(.horizontal, 56)
                .padding(.bottom, 12)
                
                Text("Generated Images Label")
                    .lineLimit(nil)
                    .font(.itimRegular(fontType: .headline))
                    .multilineTextAlignment(.center)
                    .frame(width: geo.size.width * 0.85, height: 70)
                
                ScrollView(showsIndicators: false){
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
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: geo.size.width * 0.4, height: 110)
                                        .clipShape(.rect(cornerSize: layout.pictureBorderSize))
                                        .overlay { RoundedBorder(size: layout.pictureBorderSize) }
                                        .overlay {
                                            if vm.selectedImage?.imageUrl == vm.generatedImages[imageIndex].imageUrl {
                                                selectedCircle
                                            }
                                        }
                                        .onTapGesture {
                                            vm.selectedImage = vm.generatedImages[imageIndex]
                                        }
                                        .onLongPressGesture {
                                            layout.longPressImpact.impactOccurred()
                                            vm.highlightedImage = vm.generatedImages[imageIndex]
                                            vm.showHighlightedImagePopup = true
                                        }
                                } else {
                                    ImagePlaceholder()
                                        .frame(width: geo.size.width * 0.4, height: 110)
                                }
                            }
                        }
                    }
                    .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.7)
                }
                
                ActionButton(
                    title: "Enviar",
                    foregroundColor: .blue,
                    backgroundColor: .white,
                    hasBorder: true,
                    action: {
                        if let selectedImageUrl = vm.selectedImage?.imageUrl {
                            let queue = DispatchQueue(label: "Image Data Loading")
                            queue.async(qos: .background) {
                                let imageData = try! Data(contentsOf: selectedImageUrl)
                                DispatchQueue.main.sync {
                                    session.sendArtifact(picture: imageData)
                                    router.goToSelectPlayer()
                                }
                            }
                        }
                    }
                )
                .frame(maxHeight: 42)
                .padding(.horizontal, 36)
            }
            .frame(
                width: geo.size.width,
                height: geo.size.height
            )
            .popupNavigationView(show: $vm.showSearchImagePopUp) {
                SearchImageTextInput(
                    isShowing: $vm.showSearchImagePopUp,
                    generateImagesTapped: { keywords in
                        vm.searchKeywords = keywords
                        router.goToSearchImageView(keywords: keywords)
                    }
                )
            }
            .popupNavigationView(show: $vm.showHighlightedImagePopup) {
                Rectangle()
                    .foregroundStyle(.clear)
                    .overlay {
                        AsyncImage(url: vm.highlightedImage?.imageUrl) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                        .clipShape(.rect(cornerSize: layout.pictureBorderSize))
                    }
                    .frame(maxWidth: geo.size.width * 0.8, maxHeight: geo.size.height * 0.8)
                    .padding([.horizontal], 12)
            }
            .applyHelpButton(.PickImage)
            .clioBackground()
        }
        .onAppear {
            Task {
                if vm.generatedImages.isEmpty {
                    await vm.generateImages()
                }
            }
        }
        .refreshable {
            Task {
                vm.generatedImages.removeAll()
                await vm.generateImages()
            }
        }
    }
    
    var selectedCircle: some View {
        return HStack {
            Spacer()
            VStack {
                SelectedCircle()
                    .frame(
                        width: 24,
                        height: 18
                    )
                
                Spacer()
            }
        }
    }
}

#Preview {
    NavigationView {
        PickImageView()
            .environmentObject(GameSession())
            .environmentObject(Router())
    }
}
