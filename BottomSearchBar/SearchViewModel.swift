//
//  SearchViewModel.swift
//  BottomSearchBar
//
//  Created by Damjan Dabo on 11.04.23.
//

import Foundation
import Combine

struct SearchResult: Identifiable, Equatable {
    let id = UUID()
    let name: String
}

enum SearchViewState: Equatable {
    case loading
    case loaded(searchResults: [SearchResult])
    case empty
}

final class SearchViewModel: ObservableObject {

    // MARK: - Public properties

    @Published var searchTerm = ""
    @Published var viewState: SearchViewState = .loading

    // MARK: - Private properties
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Lifecycle

    func onLoad() {
        setupSearchBinding()
    }

    // MARK: - Private funcs
    
    private func setupSearchBinding() {
        Publishers.Merge(
            $searchTerm.debounce(for: 0.4, scheduler: RunLoop.main),
            Just("") // Initial state
        )
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .removeDuplicates()
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .map { searchTerm -> [SearchResult] in
                guard searchTerm != "" else {
                    return MockData.possibleSearchResults
                }

                return MockData.possibleSearchResults.filter { searchResult in
                    return searchResult.name.lowercased().contains(searchTerm.lowercased())
                }
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] searchResults in
                guard let self else { return }

                guard !searchResults.isEmpty else {
                    self.viewState = .empty
                    return
                }

                self.viewState = .loaded(searchResults: searchResults)
            }.store(in: &cancellables)
    }
}

enum MockData {
    static let possibleSearchResults: [SearchResult] = [
        SearchResult(name: "Dog"),
        SearchResult(name: "Cat"),
        SearchResult(name: "Horse"),
        SearchResult(name: "Bird"),
        SearchResult(name: "Fish"),
        SearchResult(name: "Rabbit"),
        SearchResult(name: "Lion"),
        SearchResult(name: "Tiger"),
        SearchResult(name: "Elephant"),
        SearchResult(name: "Giraffe"),
        SearchResult(name: "Zebra"),
        SearchResult(name: "Kangaroo"),
        SearchResult(name: "Crocodile"),
        SearchResult(name: "Hippo"),
        SearchResult(name: "Gorilla"),
        SearchResult(name: "Penguin"),
        SearchResult(name: "Snake"),
        SearchResult(name: "Bear"),
        SearchResult(name: "Wolf"),
        SearchResult(name: "Fox"),
        SearchResult(name: "Deer"),
        SearchResult(name: "Monkey"),
        SearchResult(name: "Camel"),
        SearchResult(name: "Llama"),
        SearchResult(name: "Moose"),
        SearchResult(name: "Koala"),
        SearchResult(name: "Ostrich"),
        SearchResult(name: "Peacock"),
        SearchResult(name: "Raccoon"),
        SearchResult(name: "Squirrel"),
        SearchResult(name: "Chipmunk"),
        SearchResult(name: "Turtle"),
        SearchResult(name: "Frog"),
        SearchResult(name: "Toad"),
        SearchResult(name: "Shark"),
        SearchResult(name: "Octopus"),
        SearchResult(name: "Squid"),
        SearchResult(name: "Crab"),
        SearchResult(name: "Lobster"),
        SearchResult(name: "Clam"),
        SearchResult(name: "Oyster"),
        SearchResult(name: "Snail"),
        SearchResult(name: "Butterfly"),
        SearchResult(name: "Spider"),
        SearchResult(name: "Scorpion"),
        SearchResult(name: "Ant"),
        SearchResult(name: "Bee"),
        SearchResult(name: "Ladybug"),
        SearchResult(name: "Mantis")
    ]
}
