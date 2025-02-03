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
        let weight: Weight?
        let id, name, temperament, origin: String?
        let countryCodes, countryCode, lifeSpan: String?
        let wikipediaURL: String?

        enum CodingKeys: String, CodingKey {
            case weight, id, name, temperament, origin
            case countryCodes = "country_codes"
            case countryCode = "country_code"
            case lifeSpan = "life_span"
            case wikipediaURL = "wikipedia_url"
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
        self.compactMap { response in
            guard let id = response.id,
                  let width = response.width,
                  let height = response.height,
                  let url = response.url else { return nil }

            let breeds = response.breeds?.compactMap { $0.name }.joined(separator: ", ") ?? ""
            let personality = response.breeds?.compactMap { $0.temperament }.joined(separator: ", ") ?? ""

            return CatModel(
                id: id,
                width: width,
                height: height,
                imageUrl: url,
                breeds: breeds,
                personality: personality
            )
        }
    }
}

// MARK: - Mocks

extension CatResponse {
    static var mock: CatResponse {
        CatResponse(
            id: "1",
            width: 800,
            height: 600,
            url: "https://cdn2.thecatapi.com/images/mock.jpg",
            breeds: [
                Breed(
                    weight: Weight(imperial: "7 - 10", metric: "3 - 5"),
                    id: "abys",
                    name: "Abyssinian",
                    temperament: "Active, Energetic, Independent, Intelligent, Gentle",
                    origin: "Egypt",
                    countryCodes: "EG",
                    countryCode: "EG",
                    lifeSpan: "14 - 15",
                    wikipediaURL: "https://en.wikipedia.org/wiki/Abyssinian_(cat)"
                )
            ]
        )
    }
}

extension CatsListResponse {
    static var mocks: [CatResponse] {
        [
            CatResponse(
                id: "1",
                width: 800,
                height: 600,
                url: "https://cdn2.thecatapi.com/images/mock1.jpg",
                breeds: [CatResponse.Breed(
                    weight: CatResponse.Weight(imperial: "7 - 10", metric: "3 - 5"),
                    id: "abys",
                    name: "Abyssinian",
                    temperament: "Active, Energetic, Intelligent, Gentle",
                    origin: "Egypt",
                    countryCodes: "EG",
                    countryCode: "EG",
                    lifeSpan: "14 - 15",
                    wikipediaURL: "https://en.wikipedia.org/wiki/Abyssinian_(cat)"
                )]
            ),
            CatResponse(
                id: "2",
                width: 820,
                height: 620,
                url: "https://cdn2.thecatapi.com/images/mock2.jpg",
                breeds: [CatResponse.Breed(
                    weight: CatResponse.Weight(imperial: "8 - 12", metric: "4 - 6"),
                    id: "beng",
                    name: "Bengal",
                    temperament: "Alert, Agile, Energetic, Demanding, Intelligent",
                    origin: "USA",
                    countryCodes: "US",
                    countryCode: "US",
                    lifeSpan: "12 - 16",
                    wikipediaURL: "https://en.wikipedia.org/wiki/Bengal_(cat)"
                )]
            ),
            CatResponse(
                id: "3",
                width: 840,
                height: 640,
                url: "https://cdn2.thecatapi.com/images/mock3.jpg",
                breeds: [CatResponse.Breed(
                    weight: CatResponse.Weight(imperial: "9 - 11", metric: "4 - 5"),
                    id: "sibe",
                    name: "Siberian",
                    temperament: "Curious, Intelligent, Loyal, Sweet, Agile",
                    origin: "Russia",
                    countryCodes: "RU",
                    countryCode: "RU",
                    lifeSpan: "12 - 15",
                    wikipediaURL: "https://en.wikipedia.org/wiki/Siberian_(cat)"
                )]
            ),
            CatResponse(
                id: "4",
                width: 860,
                height: 660,
                url: "https://cdn2.thecatapi.com/images/mock4.jpg",
                breeds: [CatResponse.Breed(
                    weight: CatResponse.Weight(imperial: "6 - 9", metric: "3 - 4"),
                    id: "siam",
                    name: "Siamese",
                    temperament: "Affectionate, Intelligent, Social, Playful",
                    origin: "Thailand",
                    countryCodes: "TH",
                    countryCode: "TH",
                    lifeSpan: "15 - 20",
                    wikipediaURL: "https://en.wikipedia.org/wiki/Siamese_(cat)"
                )]
            ),
            CatResponse(
                id: "5",
                width: 880,
                height: 680,
                url: "https://cdn2.thecatapi.com/images/mock5.jpg",
                breeds: [CatResponse.Breed(
                    weight: CatResponse.Weight(imperial: "10 - 15", metric: "5 - 7"),
                    id: "maine",
                    name: "Maine Coon",
                    temperament: "Gentle, Independent, Intelligent, Playful",
                    origin: "USA",
                    countryCodes: "US",
                    countryCode: "US",
                    lifeSpan: "12 - 15",
                    wikipediaURL: "https://en.wikipedia.org/wiki/Maine_Coon"
                )]
            ),
            CatResponse(
                id: "6",
                width: 900,
                height: 700,
                url: "https://cdn2.thecatapi.com/images/mock6.jpg",
                breeds: [CatResponse.Breed(
                    weight: CatResponse.Weight(imperial: "7 - 10", metric: "3 - 5"),
                    id: "pers",
                    name: "Persian",
                    temperament: "Affectionate, Sweet, Quiet, Docile",
                    origin: "Iran",
                    countryCodes: "IR",
                    countryCode: "IR",
                    lifeSpan: "14 - 17",
                    wikipediaURL: "https://en.wikipedia.org/wiki/Persian_(cat)"
                )]
            ),
            CatResponse(
                id: "7",
                width: 920,
                height: 720,
                url: "https://cdn2.thecatapi.com/images/mock7.jpg",
                breeds: [CatResponse.Breed(
                    weight: CatResponse.Weight(imperial: "8 - 11", metric: "4 - 6"),
                    id: "brit",
                    name: "British Shorthair",
                    temperament: "Easygoing, Loyal, Affectionate, Social",
                    origin: "United Kingdom",
                    countryCodes: "GB",
                    countryCode: "GB",
                    lifeSpan: "12 - 15",
                    wikipediaURL: "https://en.wikipedia.org/wiki/British_Shorthair"
                )]
            ),
            CatResponse(
                id: "8",
                width: 940,
                height: 740,
                url: "https://cdn2.thecatapi.com/images/mock8.jpg",
                breeds: [CatResponse.Breed(
                    weight: CatResponse.Weight(imperial: "6 - 8", metric: "3 - 4"),
                    id: "ragd",
                    name: "Ragdoll",
                    temperament: "Affectionate, Friendly, Gentle, Social",
                    origin: "USA",
                    countryCodes: "US",
                    countryCode: "US",
                    lifeSpan: "12 - 15",
                    wikipediaURL: "https://en.wikipedia.org/wiki/Ragdoll_(cat)"
                )]
            ),
            CatResponse(
                id: "9",
                width: 960,
                height: 760,
                url: "https://cdn2.thecatapi.com/images/mock9.jpg",
                breeds: [CatResponse.Breed(
                    weight: CatResponse.Weight(imperial: "7 - 9", metric: "3 - 5"),
                    id: "birm",
                    name: "Birman",
                    temperament: "Affectionate, Gentle, Friendly, Social",
                    origin: "France",
                    countryCodes: "FR",
                    countryCode: "FR",
                    lifeSpan: "14 - 16",
                    wikipediaURL: "https://en.wikipedia.org/wiki/Birman"
                )]
            ),
            CatResponse(
                id: "10",
                width: 980,
                height: 780,
                url: "https://cdn2.thecatapi.com/images/mock10.jpg",
                breeds: [CatResponse.Breed(
                    weight: CatResponse.Weight(imperial: "8 - 12", metric: "4 - 6"),
                    id: "norw",
                    name: "Norwegian Forest Cat",
                    temperament: "Friendly, Intelligent, Social, Curious",
                    origin: "Norway",
                    countryCodes: "NO",
                    countryCode: "NO",
                    lifeSpan: "14 - 16",
                    wikipediaURL: "https://en.wikipedia.org/wiki/Norwegian_Forest_Cat"
                )]
            )
        ]
    }
}
