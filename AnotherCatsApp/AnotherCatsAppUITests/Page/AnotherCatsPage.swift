//
//  AnotherCatsPage.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-06.
//

import XCTest

struct AnotherCatsPage: Page {
    private init() { }

    @discardableResult
    static func tapOnCloseCatDetailView() -> Self.Type {
        closeButton.tapOnElement(timeout: Timeout.max)
        return self
    }

    @discardableResult
    static func tapOnLike() -> Self.Type {
        likeButton.tapOnElement(timeout: Timeout.max)
        return self
    }

    @discardableResult
    static func tapOnDislike() -> Self.Type {
        dislikeButton.tapOnElement(timeout: Timeout.max)
        return self
    }

    @discardableResult
    static func tapOnCatImage(id: String) -> Self.Type {
        catImage(id: id).tapOnElement(timeout: Timeout.max)
        return self
    }

    @discardableResult
    static func tapOnReloadButton() -> Self.Type {
        reloadButton.tapOnElement()
        return self
    }

    @discardableResult
    static func tapOnOkError() -> Self.Type {
        okErrorButton.tapOnElement()
        return self
    }
}

fileprivate extension AnotherCatsPage {
    static var scrollView: XCUIElementQuery {
        app.scrollViews
    }

    static var closeButton: XCUIElement {
        app/*@START_MENU_TOKEN@*/.buttons["closeDetailButton"]/*[[".buttons[\"Close\"]",".buttons[\"closeDetailButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
    }

    static func catImage(id: String) -> XCUIElement {
        scrollView.otherElements.buttons["catImage_\(id)"]
    }

    static var likeButton: XCUIElement {
        app/*@START_MENU_TOKEN@*/.buttons["likeButton"]/*[[".buttons[\"Love\"]",".buttons[\"likeButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
    }

    static var dislikeButton: XCUIElement {
        app.buttons["dislikeButton"]
    }

    static var reloadButton: XCUIElement {
        app.buttons["reloadButton"]
    }

    static var errorAlert: XCUIElement {
        app.alerts["Error"]
    }

    static var okErrorButton: XCUIElement {
        errorAlert.scrollViews.otherElements.buttons["OK"]
    }
}
