//
//  CatsRepository.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import Foundation

struct CatsRepository: CatsRepositoryProtocol {
    private let apiClient: APIClientProtocol
    private var decoder: JSONDecoder
    private let session: URLSession

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
        self.decoder = JSONDecoder()
        self.session = URLSession(configuration: .default)
    }

    func getCats(limit: Int, page: Int) async throws -> CatsList {
        do {
            let response: CatsListResponse = try await apiClient.performRequest(
                endpoint: CatsEndpoints.getCats(page: page, limit: limit),
                decoder: decoder
            )
            return response.toDomain()
        } catch {
            throw CatsError.networkError
        }
    }
}
