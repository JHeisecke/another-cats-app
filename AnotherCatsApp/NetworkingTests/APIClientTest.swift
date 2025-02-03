//
//  APIClientTest.swift
//  NetworkingTests
//
//  Created by Javier Heisecke on 2025-02-03.
//

import Testing
import Foundation

@testable import AnotherCatsApp

class APIClientTests {

    var apiClient: APIClientProtocol!

    init() {
        apiClient = APIClient()
    }

    deinit {
        apiClient = nil
    }

    @Test func testPerformRequest_SuccessfulResponse() async {
        do {
            let _: CatsListResponse = try await apiClient.performRequest(
                endpoint: CatsEndpoints.getCats(page: 0, limit: 1),
                decoder: JSONDecoder()
            )
        } catch {
            Issue.record("Cats endpoint call failed: \(String(describing: error.localizedDescription))")
        }
    }
}
