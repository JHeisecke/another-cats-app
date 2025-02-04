//
//  Error.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import Foundation

enum CatsError: LocalizedError {
    case networkError

    var errorDescription: String? {
        switch self {
        case .networkError:
            return "There was a network error. Try again later."
        }
    }
}
