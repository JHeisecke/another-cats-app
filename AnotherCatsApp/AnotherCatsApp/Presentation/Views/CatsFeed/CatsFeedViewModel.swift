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

    private let debouncer: Debouncer
    private let repository: CatsRepositoryProtocol
    private var isLoading = false

    private var limit: Int = Constants.numberOfCatsPerPage
    private(set) var page = 0
    private(set) var viewState: ViewState
    private(set) var cats: CatsList = []

    var scrollPosition: String?
    var showAlert: CustomAlert?

    // MARK: - Initialization

    required init(debouncer: Debouncer = Debouncer(delay: 0.3), repository: CatsRepositoryProtocol) {
        self.repository = repository
        self.viewState = .firstLoad
        self.debouncer = debouncer
    }

    deinit {
        debouncer.cancel()
    }

    // MARK: - Actions

    func getCatsFeed() async {
        guard !isLoading else { return }
        isLoading = true

        defer {
            isLoading = false
        }

        do {
            let response = try await repository.getCats(limit: limit, page: page)
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
                viewState = .data
            }
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

    func interactWithCat(currentCatId: String) {
        debouncer.call { [weak self] in
            guard let self else { return }
            guard let firstIndex = cats.firstIndex(where: { $0.id == currentCatId }), firstIndex < cats.count else { return }
            scrollPosition = cats[firstIndex + 1].id

            Task {
                if firstIndex >= self.cats.count - 5 {
                    await self.getCatsFeed()
                }
            }
        }
    }
}

// MARK: - Testing Init

extension CatsFeedViewModel {
    #if DEBUG
    convenience init(repository: CatsRepositoryProtocol, page: Int, limit: Int) {
        self.init(debouncer: Debouncer(delay: 0), repository: repository)
        self.page = page
        self.limit = limit
    }

    convenience init(repository: CatsRepositoryProtocol, isUITesting: Bool) {
        self.init(debouncer: Debouncer(delay: 0), repository: repository)
        if Utilities.hasError {
            self.page = 2
            self.limit = 10
        } else if Utilities.isEmptyFeed {
            self.page = 0
            self.limit = 0
        }
    }
    #endif
}
