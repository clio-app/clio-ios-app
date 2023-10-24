//
//  View+Extensions.swift
//  clio-app
//
//  Created by Luciana Adrião on 19/09/23.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
    
    func popupNavigationView<Content: View>(horizontalPadding: CGFloat = 40, show: Binding<Bool>, content: @escaping () -> Content) -> some View {
        return self
            .overlay {
                if show.wrappedValue {
                    GeometryReader { geo in

                        Color.black
                            .opacity(0.5)
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation {
                                    show.wrappedValue = false
                                }
                            }

                        content()
                            .frame(maxWidth: geo.size.width * 0.87, maxHeight: geo.size.height * 0.6)
                            .frame(width: geo.size.width, height: geo.size.height)

                    }
                }
            }
    }

    // MARK: - Clio Background
    func clioBackground() -> some View {
        return self
            .background{
                ZStack {
                    Color.offWhite
                        .opacity(1.0)
                        .ignoresSafeArea()
                    Image("clio-background")
                        .resizable()
                        .opacity(0.2)
                        .scaledToFill()
                        .ignoresSafeArea()

                }

            }
            .ignoresSafeArea(.keyboard)
    }

    // MARK: User profile color
    func applyColor(_ color: String) -> some View {
        return self
            .foregroundStyle(.gray, .white)
            .colorMultiply(Color(color.description))
    }
}

