//
//  Page.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-06.
//

import XCTest

protocol Page { }

extension Page {
    static var app: XCUIApplication {
        .init()
    }

    @discardableResult
    static func addDelay(seconds delay: Int = 2) -> Self.Type {
        sleep(UInt32(delay))
        return self
    }

    @discardableResult
    static func verifyIfElementExists(label: String, elementType: XCUIElement.ElementType) -> Self.Type {
        let element = app.descendants(matching: elementType)[label]

        guard element.elementExists() else {
            XCTFail("Element with label \(label) of type \(elementType) does not exists")
            return self
        }

        return self
    }
}
