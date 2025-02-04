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
class CatsFeedViewModelTests {

    var viewModel: CatsFeedViewModel!
    var repository: CatsRepositoryProtocol!
    var debouncer: Debouncer

    init() {
        repository = CatsRepository(apiClient: MockAPIClient())
        debouncer = Debouncer(delay: 0)
    }

    deinit {
        viewModel = nil
        repository = nil
    }

    @Test func testGetCatsFeed_Success() async throws {
        viewModel = CatsFeedViewModel(debouncer: debouncer, repository: repository)
        await viewModel.getCatsFeed()
        #expect(viewModel.cats.count == 10 && viewModel.viewState == .data)
    }

    @Test func testGetCatsFeed_SuccessIsEmpty() async throws {
        viewModel = CatsFeedViewModel(debouncer: debouncer, repository: repository)
        await viewModel.getCatsFeed(limit: 0)
        #expect(viewModel.viewState == .empty)
    }

    @Test func testGetCatsFeed_FailureIsEmpty() async throws {
        viewModel = CatsFeedViewModel(debouncer: debouncer, repository: repository, page: 2)
        await viewModel.getCatsFeed()
        #expect(viewModel.showAlert != nil && viewModel.viewState == .empty)
    }

    @Test func testGetCatsFeed_FailureOnSecondTry() async throws {
        viewModel = CatsFeedViewModel(debouncer: debouncer, repository: repository, page: 1)
        await viewModel.getCatsFeed()
        await viewModel.getCatsFeed()
        #expect(viewModel.showAlert != nil && viewModel.viewState == .data)
    }

    @Test func testInteractWithCat_ScrollsToNextCat() async throws {
        viewModel = CatsFeedViewModel(debouncer: debouncer, repository: repository)
        await viewModel.getCatsFeed()

        let firstCatId = viewModel.cats.first!.id
        let secondCatId = viewModel.cats[1].id

        viewModel.interactWithCat(currentCatId: firstCatId)

        try await Task.sleep(for: .seconds(0.3))

        #expect(viewModel.scrollPosition == secondCatId)
    }

    @Test func testInteractWithCat_FetchesMoreCatsWhenNearEnd() async throws {
        viewModel = CatsFeedViewModel(debouncer: debouncer, repository: repository)
        await viewModel.getCatsFeed()

        let lastFetchIndex = viewModel.cats.count - 5
        let catBeforeFetchId = viewModel.cats[lastFetchIndex].id

        viewModel.interactWithCat(currentCatId: catBeforeFetchId)

        try await Task.sleep(for: .seconds(0.3))

        #expect(viewModel.cats.count == CatsListResponse.mocks.count*2)
    }
}
