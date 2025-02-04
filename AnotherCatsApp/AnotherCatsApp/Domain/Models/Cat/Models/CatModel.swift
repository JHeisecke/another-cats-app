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
    let origin: String
    let lifeSpan: String
    let energyLevel: Int
    let affectionLevel: Int
    let sheddingLevel: Int
}

typealias CatsList = [CatModel]

extension CatModel {
    static var mock: Self {
        .init(id: "1", imageUrl: "https://cdn2.thecatapi.com/images/ctHlkAH3L.jpg", breeds: "Bengala", personality: "Curious, Social, Intelligent, Loyal, Outgoing, Adventurous, Affectionate", description: "Savannah is the feline version of a dog. Actively seeking social interaction, they are given to pouting if left out. Remaining kitten-like through life. Profoundly loyal to immediate family members whilst questioning the presence of strangers. Making excellent companions that are loyal, intelligent and eager to be involved.", origin: "Isle of Man", lifeSpan: "2", energyLevel: 3, affectionLevel: 2, sheddingLevel: 5)
    }
}
