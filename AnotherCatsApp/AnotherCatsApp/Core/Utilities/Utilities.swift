//
//  Utilities.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-04.
//

import Foundation

public struct Utilities {
    public static var isUITesting: Bool {
        return ProcessInfo.processInfo.arguments.contains("UI_TESTING")
    }
    public static var hasError: Bool {
        return ProcessInfo.processInfo.arguments.contains("HAS_ERROR")
    }
    public static var isEmptyFeed: Bool {
        return ProcessInfo.processInfo.arguments.contains("EMPTY_FEED")
    }
}
