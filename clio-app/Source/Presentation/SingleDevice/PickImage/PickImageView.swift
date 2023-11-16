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
        ForEach(vm.searchedImages.hits, id: \.id) { image in
            AsyncImage(url: URL(string: image.webformatURL)!)
        }
        
        Button("Make Request") {
            Task {
                vm.searchKeywords = "funny cats"
                await vm.searchImage()
            }
        }
    }
}

#Preview {
    PickImageView()
}
