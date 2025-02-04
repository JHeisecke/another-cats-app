//
//  MockCatsRepository.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import Foundation
import Combine

class MockCatsRepository: CatsRepositoryProtocol {

    var result: Result<CatsListResponse, CatsError>? = .success([])

    func getCats(limit: Int, page: Int) async throws -> CatsList {
        switch result {
        case .success(let response):
            return response.toDomain()
        default:
            throw CatsError.networkError
        }
    }
}
