//
//  ScrollTestView.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 20/09/23.
//

import SwiftUI
import Combine

struct KeyboardAdaptive: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight )
            .onReceive(Publishers.keyboardHeight) {
                let bottomInset = UIApplication.shared.windows.first?.safeAreaInsets.bottom
                self.keyboardHeight = $0 - (bottomInset ?? 0)
            }
            .animation(.easeInOut(duration: 0.2), value: keyboardHeight)
    }
}

extension View {
    func keyboardAdaptive() -> some View {
        return modifier(KeyboardAdaptive())
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { $0.keyboardHeight }

        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }

        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}
