//
//  MockCatsRepository.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import Foundation

class MockCatsRepository: CatsRepositoryProtocol {

    var hasError = false

    func getCats(limit: Int, page: Int) async throws -> CatsList {
        if hasError {
            throw CatsError.networkError
        } else {
            return CatsListResponse.mocks.toDomain()
        }
    }
}
