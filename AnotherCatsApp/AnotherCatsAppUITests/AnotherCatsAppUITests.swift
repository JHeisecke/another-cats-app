//
//  AnotherCatsAppUITests.swift
//  AnotherCatsAppUITests
//
//  Created by Javier Heisecke on 2025-02-03.
//

import XCTest

@MainActor
final class AnotherCatsAppUITests: XCTestCase, BaseXCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    // MARK: - Feed Testing

    func testGeneralBehavior() throws {
        launch()
        AnotherCatsPage
            .addDelay()
            .tapOnCatImage(id: "fhYh2PDcC")
            .addDelay()
            .tapOnCloseCatDetailView()
            .tapOnLike()
            .tapOnDislike()
            .tapOnDislike()
            .tapOnDislike()
            .tapOnCatImage(id: "A_G4pf_T3")
            .addDelay()
            .tapOnCloseCatDetailView()
    }

    // MARK: - Error State

    func testErrorView() throws {
        launch(extras: ["HAS_ERROR"])
        AnotherCatsPage
            .verifyIfElementExists(label: "Error", elementType: .alert)
            .tapOnOkError()
            .tapOnReloadButton()
            .verifyIfElementExists(label: "Error", elementType: .alert)
            .tapOnOkError()
    }

    // MARK: - Empty State

    func testEmptyView() throws {
        launch(extras: ["EMPTY_FEED"])
        AnotherCatsPage
            .tapOnReloadButton()
            .verifyIfElementExists(label: "The cats can't come out right now.\n Hit the reload button.", elementType: .staticText)
    }
}
