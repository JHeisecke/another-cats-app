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
    private let imageManager: ImageManager
    private let repository: CatsRepositoryProtocol
    private var isLoading = false

    private var lockAPIRequests: Bool = false
    private var limit: Int = Constants.numberOfCatsPerPage
    private(set) var page = 0
    private(set) var viewState: ViewState
    private(set) var cats: CatsList = []

    var scrollPosition: String?
    var showAlert: CustomAlert?

    // MARK: - Initialization

    required init(debouncer: Debouncer = Debouncer(delay: 0.2), imageManager: ImageManager = ImageManager(), repository: CatsRepositoryProtocol) {
        self.repository = repository
        self.viewState = .firstLoad
        self.debouncer = debouncer
        self.imageManager = imageManager
    }

    deinit {
        debouncer.cancel()
    }

    // MARK: - Actions

    func getCatsFeed(forceReload: Bool = false) async {
        guard !lockAPIRequests || forceReload else { return }
        guard !isLoading else { return }
        isLoading = true

        defer {
            isLoading = false
        }

        do {
            let newCats = try await repository.getCats(limit: limit, page: page)
            guard !newCats.isEmpty else {
                if cats.isEmpty {
                    viewState = .empty
                    imageManager.stopPrefetching()
                }
                lockAPIRequests = true
                return
            }
            Task(priority: .background) {
                imageManager.startPrefetching(urls: newCats.compactMap { URL(string: $0.imageUrl) })
            }
            if viewState != .data {
                scrollPosition = newCats.first?.id
                viewState = .data
            }
            cats.append(contentsOf: newCats)
            page += 1
            lockAPIRequests = false
        } catch {
            if cats.isEmpty {
                imageManager.stopPrefetching()
                showAlert = CustomAlert(error: error)
                viewState = .empty
            }
            lockAPIRequests = true
        }
    }

    func interactWithCat(currentCatId: String) {
        debouncer.call { [weak self] in
            guard let self else { return }
            guard let firstIndex = cats.firstIndex(where: { $0.id == currentCatId }), firstIndex < cats.count - 1 else {
                showAlert = CustomAlert(title: "No more cats!", subtitle: "All the cats have come out!\n Try again later!")
                viewState = .empty
                cats = []
                return
            }
            scrollPosition = cats[firstIndex + 1].id

            Task(priority: .background) {
                self.imageManager.removeImage(urlString: self.cats[firstIndex].imageUrl)
            }

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
