//
//  LoadingAnswer.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 28/11/23.
//

import SwiftUI

struct LoadingPoints: View {
    @State var currentPoint = 0 {
        didSet {
            animatePoints()
        }
    }
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0...2, id: \.self) { index in
                Circle()
                    .fill(currentPoint == index ? Color.lapisLazuli : Color.sky)
                    .frame(width: currentPoint == index ? 8 : 6)
            }
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 17)
        .background {
            RoundedRectangle(cornerRadius: 15)
                .stroke(.black, lineWidth: 2)
                .padding(2)
        }
        .onAppear {
            animatePoints()
        }
    }
    
    func animatePoints() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            withAnimation {
                if currentPoint == 2 {
                    currentPoint = 0
                } else {
                    currentPoint += 1
                }
            }
        }
    }
    
}

#Preview {
    LoadingPoints()
}

