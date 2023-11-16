//
//  SearchImageView.swift
//  clio-app
//
//  Created by Thiago Henrique on 12/11/23.
//

import SwiftUI
import Combine

struct SearchImageView: View {
    @StateObject private var vm = SearchImageViewModel()
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
                Text("Generated Images Sentence")
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
                .coordinateSpace(name: "scroll")
                .onReceive(publisher) { _ in
                    Task { await vm.searchImage() }
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
        .clioBackground()
        .onAppear {
            vm.searchKeywords = keywords
            Task { await vm.searchImage() }
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
    SearchImageView(keywords: "Arvore")
}
