//
//  AnotherCatsAppUITests.swift
//  AnotherCatsAppUITests
//
//  Created by Javier Heisecke on 2025-02-03.
//

import XCTest

@MainActor
final class AnotherCatsAppUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    @MainActor
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        let heartFillButton = app/*@START_MENU_TOKEN@*/.buttons["heart.fill"]/*[[".buttons[\"Love\"]",".buttons[\"heart.fill\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        heartFillButton.tap()

        let xmarkButton = app/*@START_MENU_TOKEN@*/.buttons["xmark"]/*[[".buttons[\"Close\"]",".buttons[\"xmark\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        xmarkButton.tap()
        app.scrollViews.otherElements.children(matching: .button).element(boundBy: 2).tap()
        xmarkButton.tap()
        heartFillButton.tap()
        heartFillButton.tap()
        heartFillButton.tap()
    }
}
