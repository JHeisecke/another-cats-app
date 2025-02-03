//
//  Configuration.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import Foundation

enum ConfigurationKeys {

    private enum Keys {
        static let catApiKey = "CAT_API_KEY"
    }

    private static var infoDictionary: [String: Any] {
        Bundle.main.infoDictionary ?? [:]
    }

    static var catApiKey: String {
        infoDictionary[Keys.catApiKey] as! String
    }
}
