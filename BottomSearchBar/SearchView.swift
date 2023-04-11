//
//  SearchView.swift
//  BottomSearchBar
//
//  Created by Damjan Dabo on 11.04.23.
//

import SwiftUI

struct SearchView: View {

    // MARK: - Private properties

    @StateObject private var viewModel = SearchViewModel()

    // MARK: - Lifecycle

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                mainContent
                    .padding()
            }
            CustomSearchBar(text: $viewModel.searchTerm)
        }
            .background(Color(UIColor.systemGroupedBackground), ignoresSafeAreaEdges: .all)
            .animation(.default, value: viewModel.viewState)
            .onLoad { viewModel.onLoad() }
    }

    // MARK: - Private views

    @ViewBuilder
    private var mainContent: some View {
        switch viewModel.viewState {
        case .loading:
            ProgressView()
                .accessibilityLabel("Loading search results")
                .padding()
                .cardRoundedEdges()

        case .loaded(let items):
            loadedState(with: items)
                .cardRoundedEdges()

        case .empty:
            VStack(spacing: 0) {
                Text("No search results found")
                    .multilineTextAlignment(.center)
                    .padding()
                    .fixedSize(horizontal: false, vertical: true)
            }
                .cardRoundedEdges()
        }
    }

    @ViewBuilder
    private func loadedState(with searchResults: [SearchResult]) -> some View {
        LazyVStack(alignment: .leading) {
            list(of: searchResults)
        }
            .padding(.vertical, 8)
            .cardRoundedEdges()
    }

    @ViewBuilder
    private func list(of searchResults: [SearchResult]) -> some View {
        ForEach(searchResults) { searchResult in
            Button {
                print("Selected search result \(searchResult.name)")
            } label: {
                HStack {
                    Text(searchResult.name)
                        .foregroundColor(.primary)
                        .padding(.leading)
                    Spacer() // so tap works
                }
            }
            .buttonStyle(.borderless)

            if searchResult != searchResults.last {
                Divider()
                    .padding(.leading, 16)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
