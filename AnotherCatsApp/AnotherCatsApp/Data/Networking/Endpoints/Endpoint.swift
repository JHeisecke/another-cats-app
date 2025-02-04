//
//  RequestType.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import Foundation

enum RequestType: String {
    case get = "GET"
}

protocol Endpoint {
    var scheme: String { get }
    var requestType: RequestType { get }
    var host: String { get }
    var path: String { get }
    var headers: [String: String] { get }
    var body: [AnyHashable: Any]? { get }
    var queryParams: [URLQueryItem]? { get }

    var mockFile: String? { get }
}

extension Endpoint {
    var scheme: String { "https" }
    var host: String { "api.thecatapi.com" }
    var requestType: RequestType { .get }
    var body: [AnyHashable: Any]? { nil }
    var queryParams: [URLQueryItem]? { nil }
    var mockFile: String? { nil }
    var headers: [String: String] {
        let internalHeaders = [
            "accept": "application/json",
            "x-api-key": "\(ConfigurationKeys.catApiKey)"
        ]
        return internalHeaders
    }
}

extension Endpoint {
    func asRequest(serializer: JSONSerialization.Type = JSONSerialization.self) throws -> URLRequest? {
        var urlComponent = URLComponents()
        urlComponent.scheme = scheme
        urlComponent.path = path
        urlComponent.host = host
        urlComponent.queryItems = queryParams

        guard let url = urlComponent.url else { return nil }

        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = requestType.rawValue
        if let body = body {
            urlRequest.httpBody = try serializer.data(withJSONObject: body)
        }
        return urlRequest
    }
}
