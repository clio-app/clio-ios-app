//
//  View+Extensions.swift
//  clio-app
//
//  Created by Luciana Adrião on 19/09/23.
//

import SwiftUI

extension View {
    func popupNavigationView<Content: View>(horizontalPadding: CGFloat = 40, show: Binding<Bool>, content: @escaping () -> Content) -> some View {
        return self
            .overlay {
                if show.wrappedValue {
                    GeometryReader { geo in

                        Color.black
                            .opacity(0.5)
                            .ignoresSafeArea()

                        content()
                            .frame(maxWidth: geo.size.width * 0.87, maxHeight: geo.size.height * 0.6)
                            .frame(width: geo.size.width, height: geo.size.height)

                    }
                }
            }
    }
}

