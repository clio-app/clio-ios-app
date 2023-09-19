//
//  RadialUsers.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 19/09/23.
//

import SwiftUI

struct RadialUsers: View {
    @Binding var usersList: [String]
    let masterUser: String
    
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            ForEach(0..<usersList.count, id: \.self) { index in
                let angle = 2 * .pi / Double(usersList.count) * Double(index)
                let xOffset = 40 * cos(CGFloat(angle))
                let yOffset = 40 * sin(CGFloat(angle))
                
                generateUserIcon(imageName: usersList[index])
                    .scaleEffect(isAnimating ? 1 : 0)
                    .animation(.easeInOut(duration: 0.5), value: isAnimating)
                    .offset(x: xOffset, y: yOffset)
            }
            
            generateUserIcon(imageName: masterUser, isMaster: true)
        }
        .onAppear() {
            withAnimation {
                isAnimating = true
            }
        }
    }
    
    func generateUserIcon(imageName: String, isMaster: Bool = false) -> some View {
        Circle()
            .overlay {
                Image(imageName)
                    .resizable()
                    .overlay {
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 2))
                    }
            }
            .frame(width: isMaster ? 45 : 25)
    }
    
}

#Preview {
    RadialUsers(
        usersList: .constant(["circles-picture"]),
        masterUser: "profile-picture-eye"
    )
}
