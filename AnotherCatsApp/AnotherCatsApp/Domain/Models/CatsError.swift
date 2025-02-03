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
            return "The cats can't come out right now.\n Try again later!"
        }
    }
}
