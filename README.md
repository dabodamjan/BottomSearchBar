# BottomSearchBar

Small SwiftUI sample project showing off how to implement a custom search bar on the bottom of the screen.

## Overview

This project demonstrates how to implement a custom search bar on the bottom of the screen using SwiftUI. It includes an example of how to use Combine to perform the search on mock data, and how to update the UI with the search results.

## Getting started

To get started with this project, follow these steps:

1. Clone this repository to your local machine.
2. Open the `BottomSearchBar.xcodeproj` file in Xcode.
3. Build and run the project.

## Implementation details

### SearchViewModel

SearchViewModel is responsible for handling the search query and updating the UI with the search results. It uses Combine to perform the search on mock data and publish the results to the UI. The searchTerm property is bound to the text input in the search bar, and the viewState property is updated with the search results. The setupSearchBinding() function sets up the Combine pipeline for performing the search.

### CustomSearchBar

`CustomSearchBar` is a custom view that displays a search bar on the bottom of the screen. It uses the `searchTerm` property from the `SearchViewModel` to perform the search as the user types. When the user taps the cancel button or taps outside the search bar, the search bar dismisses.

### SearchView

`SearchView` is the main view that displays the search results. 
It uses a custom replacement of SwiftUI's List for more flexibility and a `CustomSearchBar` for the search input.

## About the author

Created by Damjan Dabo. Follow me on [Twitter](https://twitter.com/DamjanDabo)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
