//
//  CatsResponse.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import Foundation

// MARK: - CatResponse

struct CatResponse: Codable {
    let id: String?
    let width, height: Int?
    let url: String?
    let breeds: [Breed]?

    // MARK: Breed

    struct Breed: Codable {
        let id, name, temperament, origin, description: String?
        let lifeSpan: String?
        let countryCodes, countryCode: String?
        let wikipediaURL, vetstreetURL: String?
        let referenceImageID: String?
        let weight: Weight?
        let adaptability, affectionLevel, childFriendly, dogFriendly: Int?
        let energyLevel, grooming, healthIssues, intelligence: Int?
        let sheddingLevel, socialNeeds, strangerFriendly, vocalisation: Int?
        let experimental, hairless, natural, rare, rex: Int?
        let shortLegs, suppressedTail, hypoallergenic, indoor: Int?
    }

    // MARK: Weight

    struct Weight: Codable {
        let imperial, metric: String?
    }
}

typealias CatsListResponse = [CatResponse]

// MARK: - To Domain

extension CatsListResponse {
    func toDomain() -> CatsList {
        var cats: CatsList = []
        for response in self {
            guard let id = response.id,
                  let url = response.url else { continue }

            let breeds = response.breeds?.compactMap { $0.name }.joined(separator: ", ") ?? "Unknown Breed"
            let personality = response.breeds?.compactMap { $0.temperament }.joined(separator: ", ") ?? "No temperament info"
            let breed = response.breeds?.first

            cats.append(CatModel(
                id: id,
                imageUrl: url,
                breeds: breeds,
                personality: personality,
                description: breed?.description ?? "No description available.",
                origin: breed?.origin ?? "Unknown",
                lifeSpan: breed?.lifeSpan ?? "Unknown",
                energyLevel: breed?.energyLevel ?? 0,
                affectionLevel: breed?.affectionLevel ?? 0,
                sheddingLevel: breed?.sheddingLevel ?? 0
            ))
        }
        return cats
    }
}
