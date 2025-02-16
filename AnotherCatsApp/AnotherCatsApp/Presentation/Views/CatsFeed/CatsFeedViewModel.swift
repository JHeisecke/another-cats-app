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
        static let maxBufferSize = 50
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

    private var isOnLastPage: Bool {
        Constants.maxBufferSize - cats.count < 9
    }

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
                print("Success empty call")
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
            appendUniqueCats(newCats)
            page += 1
            print("Success call")
            lockAPIRequests = false
        } catch {
            print("error call")
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

            guard let firstIndex = cats.firstIndex(where: { $0.id == currentCatId }) else { return }

            let isLastCat = firstIndex >= cats.count - 1
            guard !isLastCat else {
                lastCatAction()
                return
            }

            scrollPosition = cats[firstIndex + 1].id
            imageManager.removeImage(urlString: cats[firstIndex].imageUrl)

            if !isOnLastPage, firstIndex >= cats.count - 5 {
                Task { await self.getCatsFeed() }
            }
        }
    }

    private func lastCatAction() {
        if isOnLastPage {
            Task {
                viewState = .firstLoad
                cats = []
                try? await Task.sleep(for: .seconds(1))
                await getCatsFeed()
            }
        } else if lockAPIRequests {
            showAlert = CustomAlert(title: "No more cats!", subtitle: "All the cats have come out!\nTry again later!")
            viewState = .empty
            cats = []
        }
    }

    private func appendUniqueCats(_ newCats: [CatModel]) {
        let existingIds = Set(cats.map { $0.id })
        let uniqueNewCats = newCats.filter { !existingIds.contains($0.id) }
        cats.append(contentsOf: uniqueNewCats)
    }
}
