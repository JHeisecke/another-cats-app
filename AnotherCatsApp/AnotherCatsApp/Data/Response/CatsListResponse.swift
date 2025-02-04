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

        enum CodingKeys: String, CodingKey {
            case id, name, temperament, origin, description
            case lifeSpan = "life_span"
            case countryCodes = "country_codes"
            case countryCode = "country_code"
            case wikipediaURL = "wikipedia_url"
            case vetstreetURL = "vetstreet_url"
            case referenceImageID = "reference_image_id"
            case weight, adaptability, affectionLevel = "affection_level"
            case childFriendly = "child_friendly"
            case dogFriendly = "dog_friendly"
            case energyLevel = "energy_level"
            case grooming, healthIssues = "health_issues"
            case intelligence, sheddingLevel = "shedding_level"
            case socialNeeds = "social_needs"
            case strangerFriendly = "stranger_friendly"
            case vocalisation, experimental, hairless, natural, rare, rex
            case shortLegs = "short_legs"
            case suppressedTail = "suppressed_tail"
            case hypoallergenic, indoor
        }
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

// MARK: - Mocks

extension CatResponse {
    static var mock: CatResponse {
        CatResponse(
            id: "ctHlkAH3L",
            width: 1080,
            height: 1350,
            url: "https://cdn2.thecatapi.com/images/ctHlkAH3L.jpg",
            breeds: [
                Breed(
                    id: "sava",
                    name: "Savannah",
                    temperament: "Curious, Social, Intelligent, Loyal, Outgoing, Adventurous, Affectionate",
                    origin: "United States",
                    description: "Savannah is the feline version of a dog. Actively seeking social interaction, they are given to pouting if left out. Remaining kitten-like through life. Profoundly loyal to immediate family members whilst questioning the presence of strangers. Making excellent companions that are loyal, intelligent and eager to be involved.",
                    lifeSpan: "17 - 20",
                    countryCodes: "US",
                    countryCode: "US",
                    wikipediaURL: "https://en.wikipedia.org/wiki/Savannah_cat",
                    vetstreetURL: "http://www.vetstreet.com/cats/savannah",
                    referenceImageID: "a8nIYvs6S",
                    weight: Weight(imperial: "8 - 25", metric: "4 - 11"),
                    adaptability: 5,
                    affectionLevel: 5,
                    childFriendly: 4,
                    dogFriendly: 5,
                    energyLevel: 5,
                    grooming: 1,
                    healthIssues: 1,
                    intelligence: 5,
                    sheddingLevel: 3,
                    socialNeeds: 5,
                    strangerFriendly: 5,
                    vocalisation: 1,
                    experimental: 1,
                    hairless: 0,
                    natural: 0,
                    rare: 0,
                    rex: 0,
                    shortLegs: 0,
                    suppressedTail: 0,
                    hypoallergenic: 0,
                    indoor: 0
                )
            ]
        )
    }
}

extension CatsListResponse {
    static var mocks: [CatResponse] {
        [
            CatResponse.mock,
            CatResponse(
                id: "ctHlkAH3M",
                width: 1024,
                height: 1400,
                url: "https://cdn2.thecatapi.com/images/ctHlkAH3L.jpg",
                breeds: [
                    CatResponse.Breed(
                        id: "beng",
                        name: "Bengal",
                        temperament: "Alert, Agile, Energetic, Demanding, Intelligent",
                        origin: "USA",
                        description: "The Bengal is highly active and intelligent. They love to climb and explore their surroundings.",
                        lifeSpan: "12 - 16",
                        countryCodes: "US",
                        countryCode: "US",
                        wikipediaURL: "https://en.wikipedia.org/wiki/Bengal_(cat)",
                        vetstreetURL: nil,
                        referenceImageID: "bengImg",
                        weight: CatResponse.Weight(imperial: "8 - 15", metric: "4 - 7"),
                        adaptability: 5,
                        affectionLevel: 4,
                        childFriendly: 3,
                        dogFriendly: 4,
                        energyLevel: 5,
                        grooming: 2,
                        healthIssues: 2,
                        intelligence: 5,
                        sheddingLevel: 2,
                        socialNeeds: 4,
                        strangerFriendly: 4,
                        vocalisation: 3,
                        experimental: 0,
                        hairless: 0,
                        natural: 1,
                        rare: 0,
                        rex: 0,
                        shortLegs: 0,
                        suppressedTail: 0,
                        hypoallergenic: 1,
                        indoor: 0
                    )
                ]
            ),
            CatResponse(
                id: "ctHlkAH3N",
                width: 1100,
                height: 1200,
                url: "https://cdn2.thecatapi.com/images/ctHlkAH3L.jpg",
                breeds: [
                    CatResponse.Breed(
                        id: "sibe",
                        name: "Siberian",
                        temperament: "Curious, Intelligent, Loyal, Sweet, Agile",
                        origin: "Russia",
                        description: "Siberian cats are strong and intelligent, known for their affectionate nature.",
                        lifeSpan: "12 - 15",
                        countryCodes: "RU",
                        countryCode: "RU",
                        wikipediaURL: "https://en.wikipedia.org/wiki/Siberian_(cat)",
                        vetstreetURL: nil,
                        referenceImageID: "sibeImg",
                        weight: CatResponse.Weight(imperial: "8 - 17", metric: "4 - 8"),
                        adaptability: 5,
                        affectionLevel: 5,
                        childFriendly: 5,
                        dogFriendly: 4,
                        energyLevel: 4,
                        grooming: 3,
                        healthIssues: 1,
                        intelligence: 5,
                        sheddingLevel: 4,
                        socialNeeds: 5,
                        strangerFriendly: 5,
                        vocalisation: 3,
                        experimental: 0,
                        hairless: 0,
                        natural: 1,
                        rare: 0,
                        rex: 0,
                        shortLegs: 0,
                        suppressedTail: 0,
                        hypoallergenic: 1,
                        indoor: 0
                    )
                ]
            ),
            CatResponse(
                id: "ctHlkAH3O",
                width: 1150,
                height: 1300,
                url: "https://cdn2.thecatapi.com/images/ctHlkAH3L.jpg",
                breeds: [
                    CatResponse.Breed(
                        id: "siam",
                        name: "Siamese",
                        temperament: "Affectionate, Intelligent, Social, Playful",
                        origin: "Thailand",
                        description: "Siamese cats are known for their vocal nature and deep connection with their owners.",
                        lifeSpan: "15 - 20",
                        countryCodes: "TH",
                        countryCode: "TH",
                        wikipediaURL: "https://en.wikipedia.org/wiki/Siamese_(cat)",
                        vetstreetURL: nil,
                        referenceImageID: "siamImg",
                        weight: CatResponse.Weight(imperial: "6 - 14", metric: "3 - 6"),
                        adaptability: 5,
                        affectionLevel: 5,
                        childFriendly: 5,
                        dogFriendly: 4,
                        energyLevel: 5,
                        grooming: 1,
                        healthIssues: 2,
                        intelligence: 5,
                        sheddingLevel: 2,
                        socialNeeds: 5,
                        strangerFriendly: 5,
                        vocalisation: 5,
                        experimental: 0,
                        hairless: 0,
                        natural: 1,
                        rare: 0,
                        rex: 0,
                        shortLegs: 0,
                        suppressedTail: 0,
                        hypoallergenic: 0,
                        indoor: 0
                    )
                ]
            ),
            CatResponse(
                id: "ctHlkAH3P",
                width: 1200,
                height: 1400,
                url: "https://cdn2.thecatapi.com/images/ctHlkAH3L.jpg",
                breeds: [
                    CatResponse.Breed(
                        id: "maine",
                        name: "Maine Coon",
                        temperament: "Gentle, Independent, Intelligent, Playful",
                        origin: "USA",
                        description: "The Maine Coon is one of the largest domesticated breeds, known for its friendly nature.",
                        lifeSpan: "12 - 15",
                        countryCodes: "US",
                        countryCode: "US",
                        wikipediaURL: "https://en.wikipedia.org/wiki/Maine_Coon",
                        vetstreetURL: nil,
                        referenceImageID: "maineImg",
                        weight: CatResponse.Weight(imperial: "10 - 25", metric: "5 - 11"),
                        adaptability: 5,
                        affectionLevel: 4,
                        childFriendly: 5,
                        dogFriendly: 5,
                        energyLevel: 4,
                        grooming: 4,
                        healthIssues: 2,
                        intelligence: 5,
                        sheddingLevel: 4,
                        socialNeeds: 4,
                        strangerFriendly: 4,
                        vocalisation: 3,
                        experimental: 0,
                        hairless: 0,
                        natural: 1,
                        rare: 0,
                        rex: 0,
                        shortLegs: 0,
                        suppressedTail: 0,
                        hypoallergenic: 0,
                        indoor: 0
                    )
                ]
            )
        ]
    }
}
