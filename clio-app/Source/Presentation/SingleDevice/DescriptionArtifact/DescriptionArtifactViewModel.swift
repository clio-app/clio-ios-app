//
//  DescriptionArtifactViewModel.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 19/10/23.
//

import Foundation

class DescriptionArtifactViewModel : ObservableObject {
    @Published var theme: String = ""
    @Published var input = ""
    @Published var showZoomImage = false
    @Published var currentImage: String = "AppIcon"
}
