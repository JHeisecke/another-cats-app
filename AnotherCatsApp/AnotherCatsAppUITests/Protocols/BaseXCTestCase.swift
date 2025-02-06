//
//  BaseXCTestCase.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-06.
//

import XCTest

protocol BaseXCTestCase where Self: XCTestCase {
    var app: XCUIApplication { get }
    func launch()
}

extension BaseXCTestCase {
    var app: XCUIApplication { .init() }

    func launch() {
        launch(extras: [])
    }

    func launch(extras: [String] = []) {
        let app = XCUIApplication()
        app.launchArguments = [
            "UI_TESTING"
        ]

        if !extras.isEmpty {
            app.launchArguments.append(contentsOf: extras)
        }

        app.launch()
    }
}
