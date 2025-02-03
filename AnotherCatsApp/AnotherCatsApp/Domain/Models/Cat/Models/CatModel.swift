//
//  CatsModel.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import Foundation

// MARK: - CatResponse

struct CatModel {
    let id: String
    let width, height: Int
    let imageUrl: String
    let breeds: String
    let personality: String
}

typealias CatsList = [CatModel]
