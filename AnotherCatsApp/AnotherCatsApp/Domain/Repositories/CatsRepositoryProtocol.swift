//
//  CatsRepositoryProtocol.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import Foundation

protocol CatsRepositoryProtocol {
    func getCats(limit: Int, page: Int) async throws -> CatsList
}
