//
//  Data+Extensions.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import Foundation

extension Data {
    var prettyPrintedJSONString: String? {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: self, options: [])
            let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
            return String(data: prettyData, encoding: .utf8)
        } catch {
            return nil
        }
    }
}
