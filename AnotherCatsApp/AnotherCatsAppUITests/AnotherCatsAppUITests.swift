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

    func testGeneralBehavior() throws {
        let app = XCUIApplication()
        app.launchArguments = ["UI_TESTING"]
        app.launch()
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery/*@START_MENU_TOKEN@*/.buttons["catImage_fhYh2PDcC"]/*[[".buttons[\"Manx, Easy Going, Intelligent, Loyal, Playful, Social\"]",".buttons[\"catImage_fhYh2PDcC\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        elementsQuery/*@START_MENU_TOKEN@*/.children(matching: .image).matching(identifier: "star.fill").element(boundBy: 12)/*[[".children(matching: .image).matching(identifier: \"Favorite\").element(boundBy: 12)",".children(matching: .image).matching(identifier: \"star.fill\").element(boundBy: 12)"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        elementsQuery/*@START_MENU_TOKEN@*/.children(matching: .image).matching(identifier: "star.fill").element(boundBy: 4)/*[[".children(matching: .image).matching(identifier: \"Favorite\").element(boundBy: 4)",".children(matching: .image).matching(identifier: \"star.fill\").element(boundBy: 4)"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        let closedetailbuttonButton = app/*@START_MENU_TOKEN@*/.buttons["closeDetailButton"]/*[[".buttons[\"Close\"]",".buttons[\"closeDetailButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        closedetailbuttonButton.tap()
        let likebuttonButton = app/*@START_MENU_TOKEN@*/.buttons["likeButton"]/*[[".buttons[\"Love\"]",".buttons[\"likeButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        likebuttonButton.tap()
        likebuttonButton.tap()
        likebuttonButton.tap()
        elementsQuery/*@START_MENU_TOKEN@*/.buttons["catImage_1TcC-kiI1"]/*[[".buttons[\"Korat, Active, Loyal, highly intelligent, Expressive, Trainable\"]",".buttons[\"catImage_1TcC-kiI1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        closedetailbuttonButton.tap()
    }

    func testErrorView() throws {
        let app = XCUIApplication()
        app.launchArguments = ["UI_TESTING", "HAS_ERROR"]
        app.launch()
        let okButton = app.alerts["Error"].scrollViews.otherElements.buttons["OK"]
        okButton.tap()
        app/*@START_MENU_TOKEN@*/.buttons["arrow.clockwise"]/*[[".buttons[\"Refresh\"]",".buttons[\"arrow.clockwise\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        okButton.tap()
    }

    func testEmptyView() throws {
        let app = XCUIApplication()
        app.launchArguments = ["UI_TESTING", "EMPTY_FEED"]
        app.launch()
        app/*@START_MENU_TOKEN@*/.buttons["arrow.clockwise"]/*[[".buttons[\"Refresh\"]",".buttons[\"arrow.clockwise\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.staticTexts["The cats can't come out right now.\n Hit the reload button."].tap()
    }
}
