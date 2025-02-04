//
//  CatsFeedViewModelTests.swift
//  AnotherCatsAppTests
//
//  Created by Javier Heisecke on 2025-02-03.
//

import Testing

@testable import AnotherCatsApp

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
        await viewModel.getCatsFeed()
        #expect(viewModel.cats.count == 10 && viewModel.viewState == .data)
    }

    @Test func testGetCatsFeed_Failure() async throws {
        repository.hasError = true
        await viewModel.getCatsFeed()
        #expect(viewModel.showAlert != nil && viewModel.viewState == .empty)
    }

    @Test func testGetCatsFeed_FailureOnSecondtry() async throws {
        await viewModel.getCatsFeed()
        repository.hasError = true
        await viewModel.getCatsFeed()
        #expect(viewModel.showAlert != nil && viewModel.viewState == .data)
    }

}
