//
//  LoadingPlayer.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 27/10/23.
//

import SwiftUI

struct LoadingPlayer: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                ProgressView()
                    .tint(Color.lapisLazuli)
                Text("Buscando jogador...")
                    .foregroundColor(.lapisLazuli)
                    .font(.itimRegular(fontType: .headline))
            }
        }
    }
}

#Preview {
    LoadingPlayer()
}
