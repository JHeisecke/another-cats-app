//
//  MockAPIClient.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-04.
//

import Foundation

class MockAPIClient: NSObject, APIClientProtocol {

    var hasError: Bool
    var isEmpty: Bool

    init(hasError: Bool = false, isEmpty: Bool = false) {
        self.hasError = hasError
        self.isEmpty = isEmpty
    }

    func performRequest<T>(endpoint: any Endpoint, decoder: JSONDecoder) async throws -> T where T: Decodable {
        if hasError {
            throw CatsError.networkError
        }

        if isEmpty {
            return try await decodeJson(mockfile: "cats-empty", decoder: JSONDecoder())
        }
        if let mockfile = endpoint.mockFile {
            return try await decodeJson(mockfile: mockfile, decoder: JSONDecoder())
        }
        throw CatsError.networkError
    }

    private func decodeJson<T>(mockfile: String, decoder: JSONDecoder) async throws -> T where T: Decodable {
        if let path = Bundle.main.path(forResource: mockfile, ofType: "json") {
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            let decodedData = try decoder.decode(T.self, from: data)
            try? await Task.sleep(for: .seconds(2))
            return decodedData
        }
        throw CatsError.networkError
    }
}
