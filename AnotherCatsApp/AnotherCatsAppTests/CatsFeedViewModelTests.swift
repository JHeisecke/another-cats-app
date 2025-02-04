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
    var repository: MockCatsRepository!

    init() {
        repository = MockCatsRepository()
        viewModel = CatsFeedViewModel(debouncer: Debouncer(delay: 0), repository: repository)
    }

    deinit {
        viewModel = nil
        repository = nil
    }

    @Test func testGetCatsFeed_Success() async throws {
        repository.result = .success(CatsListResponse.mocks)
        await viewModel.getCatsFeed()
        #expect(viewModel.cats.count == CatsListResponse.mocks.count && viewModel.viewState == .data)
    }

    @Test func testGetCatsFeed_SuccessEmpty() async throws {
        repository.result = .success([])
        await viewModel.getCatsFeed()
        #expect(viewModel.viewState == .empty)
    }

    @Test func testGetCatsFeed_Failure() async throws {
        repository.result = .failure(CatsError.networkError)
        await viewModel.getCatsFeed()
        #expect(viewModel.showAlert != nil && viewModel.viewState == .empty)
    }

    @Test func testGetCatsFeed_FailureOnSecondtry() async throws {
        repository.result = .success(CatsListResponse.mocks)
        await viewModel.getCatsFeed()
        repository.result = .failure(CatsError.networkError)
        await viewModel.getCatsFeed()
        #expect(viewModel.showAlert != nil && viewModel.viewState == .data)
    }

    @Test func testInteractWithCat_ScrollsToNextCat() async throws {
        repository.result = .success(CatsListResponse.mocks)

        await viewModel.getCatsFeed()

        let firstCatId = viewModel.cats.first!.id
        let secondCatId = viewModel.cats[1].id

        viewModel.interactWithCat(currentCatId: firstCatId)

        try await Task.sleep(for: .seconds(0.3))

        #expect(viewModel.scrollPosition == secondCatId)
    }

    @Test func testInteractWithCat_FetchesMoreCatsWhenNearEnd() async throws {
        repository.result = .success(CatsListResponse.mocks)

        await viewModel.getCatsFeed()

        let lastFetchIndex = viewModel.cats.count - 5
        let catBeforeFetchId = viewModel.cats[lastFetchIndex].id

        repository.result = .success(CatsListResponse.mocks)
        viewModel.interactWithCat(currentCatId: catBeforeFetchId)

        try await Task.sleep(for: .seconds(0.3))

        #expect(viewModel.cats.count == CatsListResponse.mocks.count*2)
    }
}
