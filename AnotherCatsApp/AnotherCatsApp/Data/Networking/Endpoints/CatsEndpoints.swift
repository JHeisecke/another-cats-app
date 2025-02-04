//
//  CatsEndpoints.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import Foundation

enum CatsEndpoints {
    case getCats(page: Int, limit: Int = 10)
}

extension CatsEndpoints: Endpoint {
    var path: String {
        "/v1/images/search"
    }

    var queryParams: [URLQueryItem]? {
        switch self {
        case .getCats(let page, let limit):
            [URLQueryItem(name: "limit", value: "\(limit)"), URLQueryItem(name: "page", value: "\(page)")]
        }
    }

    var mockFile: String? {
        switch self {
        case .getCats(let page, let limit):
            if limit == 0 {
                return "cats-empty"
            }
            switch page {
            case 0:
                return "cats-page-one"
            case 1:
                return "cats-page-two"
            default:
                return nil
            }
        }
    }
}
