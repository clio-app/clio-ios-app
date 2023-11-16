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
                VStack {
                    Text("Generate Image Action Description")
                        .font(.itimRegular(fontType: .body))
                        .multilineTextAlignment(.center)
                    
                    TextFieldView(
                        inputText: $vm.searchKeywords,
                        placeholder: "Ex.: Árvores...",
                        color: .yellow
                    )
                    .padding([.horizontal], 32)
                    
                    ActionButton(
                        title: "Generate Image Button",
                        foregroundColor: .yellow,
                        hasBorder: false,
                        action: {}
                    )
                    .frame(height: 42)
                    .padding(.horizontal, 42)
                    .padding(.top, 16)
                }
                .frame(height: geo.size.height * 0.3)
                
                VStack {
                    Text("Generated Images Label")
                        .font(.itimRegular(fontType: .headline))
                        .multilineTextAlignment(.center)
                        
                    Rectangle()
                        .foregroundStyle(.clear)
                        .overlay {
                            ForEach(vm.searchedImages.hits, id: \.id) { image in
                                
                            }
                        }
                        .frame(
                            width: geo.size.width * 0.9,
                            height: geo.size.height * 0.45
                        )
                    
                    ActionButton(
                        title: "Enviar",
                        foregroundColor: .blue,
                        backgroundColor: .white,
                        hasBorder: true,
                        action: {}
                    )
                    .frame(maxHeight: 42)
                    .padding(.horizontal, 36)
                    .padding(.top, 16)
                }
                .frame(height: geo.size.height * 0.6)
//                ForEach(vm.searchedImages.hits, id: \.id) { image in
    //                AsyncImage(url: URL(string: image.webformatURL)!)
    //            }
    //
    //            Button("Make Request") {
    //                Task {
    //                    vm.searchKeywords = "funny cats"
    //                    await vm.searchImage()
    //                }
    //            }
            }
            .padding([.top], 25)
        }
    }
}

#Preview {
    PickImageView()
}
