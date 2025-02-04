//
//  CatsFeedViewModel.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import Foundation

@Observable
class CatsFeedViewModel {

    // MARK: - Types

    enum ViewState {
        case firstLoad
        case empty
        case data
    }

    struct Constants {
        static let numberOfCatsPerPage = 10
    }

    // MARK: - Properties

    private let repository: CatsRepositoryProtocol

    private(set) var page = 0
    private(set) var viewState: ViewState = .firstLoad
    private(set) var cats: CatsList = []

    var scrollPosition: Int?
    var showAlert: CustomAlert?

    // MARK: - Initialization

    init(repository: CatsRepositoryProtocol) {
        self.repository = repository
    }

    // MARK: - Actions

    func getCatsFeed() async {
        do {
            let response = try await repository.getCats(limit: Constants.numberOfCatsPerPage, page: page)
            guard !response.isEmpty else {
                if cats.isEmpty {
                    viewState = .empty
                } else {
                    showAlert = CustomAlert(title: "No more cats!", subtitle: "All the cats have come out!")
                }
                return
            }
            viewState = .data
            cats.append(contentsOf: response)
            page += 1
            scrollPosition = 0
        } catch {
            if cats.isEmpty {
                showAlert = CustomAlert(error: error)
                viewState = .empty
            } else {
                showAlert = CustomAlert(title: "No more cats!", subtitle: "All cats have come out!\n Try again later!")
            }
        }
    }

    func interactWithCat() {
        guard let catIndex = scrollPosition else { return }
        Task {
            if catIndex >= cats.count - 1 {
                await getCatsFeed()
            } else {
                scrollPosition = catIndex + 1
            }
        }
    }
}
