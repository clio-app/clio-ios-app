//
//  Reaction.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 14/11/23.
//

import SwiftUI

struct ReactionButton: View {
    @Binding var showSelectEmoji: Bool
    @Binding var selectedIndex: Int
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack(alignment: .trailing) {
                RoundedRectangle(cornerRadius: geo.size.height/2)
                    .fill(.white)
                    .frame(width: showSelectEmoji ? geo.size.width: geo.size.height, height: geo.size.height)
                    .overlay {
                        HStack(spacing: 1) {
                            if showSelectEmoji {
                                ForEach(1...5, id: \.self) { index in
                                   Circle()
                                        .fill( index == selectedIndex ? Color.sky : .white)
                                        .overlay {
                                           Image("Emoji\(index)")
                                               .resizable()
                                               .scaledToFit()
                                               .padding(.leading, 3)
           
                                       }
                                       .onTapGesture {
                                           UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                                           selectedIndex = index
                                           DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                               toggleButton()
                                           }
                                       }
                                }
                                .transition(.asymmetric(
                                    insertion: .scale.animation(.easeInOut.delay(0.3)),
                                    removal: .identity
                                ))
                            }
                            else {
                                Image(selectedIndex != 0 ? "Emoji\(selectedIndex)" : "EmojiButton")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.top, 2)
                                    .padding(.leading, 4)
                                    .padding(selectedIndex != 0 ? 3 : 0)
                            }
                        }
                        .padding(.horizontal, showSelectEmoji ? 5 : 0)
                        .onTapGesture {
                            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                            toggleButton()
                        }
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: geo.size.height/2)
                            .stroke(.black, lineWidth: 2)
                    }
                
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .trailing)
        }
    }
    
    func toggleButton() {
        withAnimation {
            showSelectEmoji.toggle()
        }
    }
}

#Preview {
    @State var showSelectEmoji = false
    @State var selectedIndex: Int = 0
    
    
    return( GeometryReader { geo in
        VStack {
            ReactionButton(showSelectEmoji: $showSelectEmoji, selectedIndex: $selectedIndex)
                .frame(maxWidth:geo.size.width * 0.8, maxHeight: geo.size.width * 0.2)
            
        }
        .frame(width: geo.size.width, height: geo.size.height)
    })
}
