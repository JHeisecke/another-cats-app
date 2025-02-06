//
//  AccessibilityIdentifiers.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-04.
//

import Foundation

struct AccessibilityIdentifiers {
    static let likeButton = "likeButton"
    static let reloadButton = "reloadButton"
    static let dislikeButton = "dislikeButton"
    static let closeDetailButton = "closeDetailButton"
    static func catImage(_ id: String) -> String { "catImage_\(id)" }
}
