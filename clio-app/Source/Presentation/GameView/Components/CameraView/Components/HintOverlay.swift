//
//  HintOverlay.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 10/10/23.
//

import SwiftUI

struct HintOverlay: View {
    @Binding var theme: String
    @State var showHint: Bool = false {
        didSet {
            buttonName = showHint ? "chevron.up.circle.fill" : "chevron.down.circle.fill"
        }
    }
    @State var buttonName = "chevron.up.circle.fill"
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: buttonName)
                            .symbolRenderingMode(.hierarchical)
                            .resizable()
                            .foregroundColor(.gray)
                            .frame(width: 40, height: 40)
                            .onTapGesture {
                                toggleHintCard()
                            }
                        
                    }
                    .padding(.trailing)
                    .gesture(dragGesture)
                    
                    if showHint {
                        hintCard
                            .padding(.top, 60)
                            .frame(
                                width: geo.size.width * 0.9,
                                height: geo.size.height * 0.25
                            )
                            .transition(.asymmetric(insertion: .move(edge: .top),
                                                    removal: AnyTransition.move(edge: .top)))
                            .gesture(dragGesture)
                    }
                    Spacer()
                }
            }
        }
        .onAppear {
            withAnimation {
                showHint = true
            }
        }
    }
    
    func toggleHintCard() {
        withAnimation {
            showHint.toggle()
        }
    }
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onEnded(handleDrag)
    }
    
    func handleDrag(value: DragGesture.Value) {
        if value.translation.height < 0 {
            withAnimation() {
                showHint = false
            }
        }
        if value.translation.height > 0 {
            withAnimation() {
                showHint = true
            }
        }
    }
}

extension HintOverlay {
    var hintCard : some View {
        ZStack {
            BorderedBackground(
                foregroundColor: .white,
                backgroundColor: .customPink,
                hasBorder: true
            )
            .padding()
            
            Text("Tire uma foto sobre o tema \(theme)")
                .font(.itimRegular(fontType: .title3))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

#Preview {
    HintOverlay(theme: .constant("Guerra Fria"))
}
