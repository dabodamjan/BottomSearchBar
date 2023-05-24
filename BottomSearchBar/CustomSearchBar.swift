//
//  CustomSearchBar.swift
//  BottomSearchBar
//
//  Created by Damjan Dabo on 11.04.23.
//

import SwiftUI

struct CustomSearchBar: View {

    @Binding var text: String

    @FocusState private var isFocused: Bool
    @State private var showCancelButton: Bool = false

    var body: some View {
        HStack {
            HStack(spacing: 4) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(UIColor.secondaryLabel))

                TextField("Search", text: $text)
                    .accessibilityAddTraits(.isSearchField)
                    .focused($isFocused)
                    .foregroundColor(.primary)

                if !text.isEmpty && isFocused {
                    Button(action: {
                        withAnimation {
                            text = ""
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .accessibilityLabel("Clear text")
                            .foregroundColor(Color(UIColor.secondaryLabel))
                    }
                }
            }
                .padding(.vertical, 6)
                .padding(.horizontal, 6)
                .background(Color(UIColor.secondarySystemGroupedBackground))
                .cornerRadius(10)

            if showCancelButton {
                Button("Cancel") {
                    withAnimation {
                        isFocused = false
                        text = ""
                    }
                }
                .transition(.opacity)
            }
        }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .onChange(of: isFocused) { isFocused in
                withAnimation {
                    showCancelButton = isFocused
                }
            }
            .onAppear { isFocused = true }
    }
}

struct CustomSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomSearchBar(text: .constant(""))
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color(UIColor.systemGroupedBackground))
    }
}
