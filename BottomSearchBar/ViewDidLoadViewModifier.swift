//
//  DidLoadViewModifier.swift
//  GoldenSquirrel
//
//  Created by Damjan Dabo on 16.11.21.
//

import SwiftUI

/// From https://stackoverflow.com/a/64495887
struct DidLoadViewModifier: ViewModifier {

    @State private var didLoad = false
    private let action: (() -> Void)?

    init(perform action: (() -> Void)? = nil) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            if didLoad == false {
                didLoad = true
                action?()
            }
        }
    }

}

extension View {

    /// Adds an action to perform when this view is loaded.
    /// Called only once, unlike `onAppear`. Replacement for `viewDidLoad` from UIKit.
    ///
    /// - Parameter action: The action to perform. If `action` is `nil`, the
    ///   call has no effect.
    ///
    /// - Returns: A view that triggers `action` when this view appears.
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(DidLoadViewModifier(perform: action))
    }

}
