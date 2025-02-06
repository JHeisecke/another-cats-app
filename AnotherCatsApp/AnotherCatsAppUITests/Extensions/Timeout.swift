//
//  Timeout.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-06.
//


import XCTest

enum Timeout {
    static var `default`: TimeInterval { 5 }
    static var max: TimeInterval { 10 }
}

extension XCUIElement {
    /// Verify element existence and then proceed with tapping on it
    func tapOnElement(timeout: TimeInterval = Timeout.default) {
        guard elementExists(timeout: timeout) else {
            XCTFail("\(description) does not exists")
            return
        }
        tap()
    }

    /// Verify element existence on the app view hierarchy
    func elementExists(timeout: TimeInterval = Timeout.default) -> Bool {
        waitForExistence(timeout: timeout)
    }

    func fillTextField(_ text: String) {
        guard elementExists() else {
            XCTFail("\(description) does not exists")
            return
        }

        typeText(text)
    }
}
