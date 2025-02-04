//
//  CatsModel.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import Foundation

// MARK: - CatResponse

struct CatModel: Identifiable, Hashable {
    let id: String
    let imageUrl: String
    let breeds: String
    let personality: String
    let description: String
}

typealias CatsList = [CatModel]
