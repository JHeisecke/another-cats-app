//
//  MockAPIClient.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-04.
//

import Foundation

class MockAPIClient: NSObject, APIClientProtocol {
    func performRequest<T>(endpoint: any Endpoint, decoder: JSONDecoder) async throws -> T where T: Decodable {
        if let mockfile = endpoint.mockFile, let path = Bundle.main.path(forResource: mockfile, ofType: "json") {
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            let decodedData = try decoder.decode(T.self, from: data)
            try? await Task.sleep(for: .seconds(2))
            return decodedData
        }
        throw CatsError.networkError
    }
}
