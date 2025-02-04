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
        viewModel = CatsFeedViewModel(repository: repository)
    }

    deinit {
        viewModel = nil
        repository = nil
    }

    @Test func testGetCatsFeed_Success() async throws {
        repository.result = .success(CatsListResponse.mocks)
        await viewModel.getCatsFeed()
        #expect(viewModel.cats.count == 10 && viewModel.viewState == .data)
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

}
