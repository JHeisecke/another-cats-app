//
//  CatsFeedViewModel.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import Foundation

@MainActor
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
    private var isLoading = false

    private(set) var page = 0
    private(set) var viewState: ViewState = .firstLoad
    private(set) var cats: CatsList = []

    var scrollPosition: String?
    var showAlert: CustomAlert?

    // MARK: - Initialization

    init(repository: CatsRepositoryProtocol) {
        self.repository = repository
    }

    // MARK: - Actions

    func getCatsFeed() async {
        guard !isLoading else { return }
        isLoading = true

        defer {
            isLoading = false
        }

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
            if viewState == .firstLoad {
                scrollPosition = response.first?.id
            }
            viewState = .data
            cats.append(contentsOf: response)
            page += 1
        } catch {
            if cats.isEmpty {
                showAlert = CustomAlert(error: error)
                viewState = .empty
            } else {
                showAlert = CustomAlert(title: "No more cats!", subtitle: "All cats have come out!\n Try again later!")
            }
        }
    }

    func fetchMoreCatsIfNecessary(currentCatId: String) {
        guard let firstIndex = cats.firstIndex(where: { $0.id == currentCatId }) else { return }
        Task {
            if firstIndex >= cats.count/2 {
                await getCatsFeed()
            }
        }
    }

    func interactWithCat(currentCatId: String) {
        guard let firstIndex = cats.firstIndex(where: { $0.id == currentCatId }), firstIndex < cats.count else { return }
        scrollPosition = cats[firstIndex + 1].id
    }
}
