//
//  CardRoundedEdges.swift
//  GoldenSquirrel
//
//  Created by Damjan Dabo on 07.06.22.
//

import SwiftUI

private struct CardRoundedEdges: ViewModifier {

    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(UIColor.secondarySystemGroupedBackground))
            content
        }
    }
}

extension View {

    /// Makes edges of the view rounded.
    /// - Returns: A view with rounded edges.
    func cardRoundedEdges() -> some View {
        modifier(CardRoundedEdges())
    }
}
