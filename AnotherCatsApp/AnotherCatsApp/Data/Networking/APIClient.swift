//
//  APIClient.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import Foundation
import os

enum APIError: Error {
    case genericError
}

protocol APIClientProtocol {
    func performRequest<T: Decodable>(endpoint: Endpoint, decoder: JSONDecoder) async throws -> T
}

final class APIClient: NSObject, APIClientProtocol {

    private lazy var logger: Logger = .init()

    func performRequest<T: Decodable>(endpoint: Endpoint, decoder: JSONDecoder) async throws -> T {

        guard let urlRequest = try? endpoint.asRequest() else {
            throw APIError.genericError
        }

        do {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 10
            configuration.timeoutIntervalForResource = 10
            configuration.requestCachePolicy = .returnCacheDataElseLoad
            configuration.urlCache = URLCache.shared

            let (data, response) = try await URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
                .data(for: urlRequest)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.genericError
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.genericError
            }
            let cachedResponse = CachedURLResponse(response: response, data: data)
            URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)

            let decodedData = try decoder.decode(T.self, from: data)

            logger.debug("\(response.url?.absoluteString ?? ""): \(data.prettyPrintedJSONString ?? "")")

            return decodedData
        } catch {
            if (error as NSError).code == NSURLErrorTimedOut {
                throw APIError.genericError
            }
            print(String(describing: error))
            throw error
        }
    }
}
