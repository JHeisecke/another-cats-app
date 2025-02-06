//
//  CatsFeedViewModelTests.swift
//  AnotherCatsAppTests
//
//  Created by Javier Heisecke on 2025-02-03.
//

import Testing
import Combine

@testable import AnotherCatsApp

@MainActor
struct CatsFeedViewModelTests {

    // MARK: - Get Cats

    @Test func testGetCatsFeed_Success() async throws {
        let repository = CatsRepository(apiClient: MockAPIClient())
        let viewModel = CatsFeedViewModel(repository: repository)
        await viewModel.getCatsFeed()
        #expect(viewModel.cats.count == 10 && viewModel.viewState == .data)
    }

    @Test func testGetCatsFeed_SuccessIsEmpty() async throws {
        let repository = CatsRepository(apiClient: MockAPIClient(isEmpty: true))
        let viewModel = CatsFeedViewModel(repository: repository)
        await viewModel.getCatsFeed()
        #expect(viewModel.viewState == .empty)
    }

    @Test func testGetCatsFeed_FailureIsEmpty() async throws {
        let repository = CatsRepository(apiClient: MockAPIClient(hasError: true))
        let viewModel = CatsFeedViewModel(repository: repository)
        await viewModel.getCatsFeed()
        #expect(viewModel.showAlert != nil && viewModel.viewState == .empty)
    }

    // MARK: - Interact With Cats

    @Test func testInteractWithCat_ScrollsToNextCat() async throws {
        let repository = CatsRepository(apiClient: MockAPIClient())
        let viewModel = CatsFeedViewModel(repository: repository)
        await viewModel.getCatsFeed()

        let firstCatId = viewModel.cats.first!.id
        let secondCatId = viewModel.cats[1].id

        viewModel.interactWithCat(currentCatId: firstCatId)

        try await Task.sleep(for: .seconds(0.3))

        #expect(viewModel.scrollPosition == secondCatId)
    }

    @Test func testInteractWithCat_FetchesMoreCatsWhenNearEnd() async throws {
        let repository = CatsRepository(apiClient: MockAPIClient())
        let viewModel = CatsFeedViewModel(debouncer: Debouncer(delay: 0), repository: repository)
        await viewModel.getCatsFeed()

        let lastFetchIndex = viewModel.cats.count - 5
        let catBeforeFetchId = viewModel.cats[lastFetchIndex].id

        viewModel.interactWithCat(currentCatId: catBeforeFetchId)

        try await Task.sleep(for: .seconds(3))

        #expect(viewModel.cats.count == 20)
    }

    @Test func testInteractWithCat_FailureNoMoreCats() async throws {
        let apiClient = MockAPIClient()
        let viewModel = CatsFeedViewModel(debouncer: Debouncer(delay: 0), repository: CatsRepository(apiClient: apiClient))
        await viewModel.getCatsFeed()

        let secondToLastCatId = viewModel.cats[viewModel.cats.count - 2].id
        let lastCatId = viewModel.cats.last!.id

        apiClient.isEmpty = true
        viewModel.interactWithCat(currentCatId: secondToLastCatId)
        try await Task.sleep(for: .seconds(3))

        viewModel.interactWithCat(currentCatId: lastCatId)
        try await Task.sleep(for: .seconds(3))

        #expect(viewModel.cats.isEmpty)
        #expect(viewModel.viewState == .empty)
        #expect(viewModel.showAlert != nil)
    }
}
