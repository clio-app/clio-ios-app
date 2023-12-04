//
//  SearchImageView.swift
//  clio-app
//
//  Created by Thiago Henrique on 12/11/23.
//

import SwiftUI
import Combine
import ClioDomain

struct SearchImageView: View {
    @EnvironmentObject var session: GameSession
    @EnvironmentObject var router: Router
    @StateObject private var vm = SearchImageViewModel()
    
    private let layout = SearchImageViewLayout()
    let keywords: String
    let detector: CurrentValueSubject<CGFloat, Never>
    let publisher: AnyPublisher<CGFloat, Never>

    init(keywords: String) {
        let detector = CurrentValueSubject<CGFloat, Never>(0)
        self.detector = detector
        self.keywords = keywords
        self.publisher = detector
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .dropFirst()
            .eraseToAnyPublisher()
     }
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                if vm.searchedImages.count > 0 {
                    ScrollView {
                        Text("Generated Images Sentence")
                            .lineLimit(nil)
                            .font(.itimRegular(fontType: .headline))
                            .multilineTextAlignment(.center)
                            .frame(width: geo.size.width, height: 70)
                        
                        LazyVGrid(
                            columns: [
                                GridItem(.fixed(geo.size.height * 0.25)),
                                GridItem(.fixed(geo.size.height * 0.25))
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
                                                .rect(cornerSize: layout.pictureBorderSize)
                                            )
                                            .overlay {
                                                if vm.selectedImage?.imageUrl == vm.searchedImages[index].imageUrl {
                                                    selectedCircle
                                                }
                                            }
                                            .onTapGesture {
                                                vm.selectedImage = vm.searchedImages[index]
                                            }
                                            .onLongPressGesture {
                                                layout.longPressImpact.impactOccurred()
                                                vm.highlightedImage = vm.searchedImages[index]
                                                vm.showHighlightedImagePopup = true
                                            }
                                    } else {
                                        ImagePlaceholder()
                                            .frame(width: geo.size.width * 0.4, height: 110)
                                    }
                                }
                            }
                        }
                        .background(
                            GeometryReader {
                                Color.clear.preference(
                                    key: ViewOffsetKey.self,
                                    value: -$0.frame(in: .named("scroll")).origin.y
                                )
                            }
                        )
                        .onPreferenceChange(ViewOffsetKey.self) { detector.send($0) }
                    }
                    .padding([.top], 4)
                    .coordinateSpace(name: "scroll")
                    .onReceive(publisher) { _ in
                        Task { await vm.searchImage() }
                    }
                } else {
                    Spacer()
                    
                    Text("Search Images Empty State Sentence")
                        .lineLimit(nil)
                        .font(.itimRegular(fontType: .headline))
                        .multilineTextAlignment(.center)
                }
    
                Spacer()
                
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
            .frame(width: geo.size.width, height: geo.size.height)
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
        }
        .clioBackground()
        .applyHelpButton(.SearchImage(vm.searchKeywords))
        .onAppear {
            vm.searchKeywords = keywords
            Task { await vm.searchImage() }
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

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

#Preview {
    NavigationStack {
        SearchImageView(keywords: "Arvore")
    }
}
