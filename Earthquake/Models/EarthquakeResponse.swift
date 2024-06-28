//
//  EarthquakeResponse.swift
//  Earthquake
//
//  Created by EMTECH MAC on 28/06/2024.
//


import Foundation

struct EarthquakeResponse: Codable {
    let features: [Feature]

    struct Feature: Codable {
        let properties: Properties
        let geometry: Geometry
        let id: String

        struct Properties: Codable {
            let place: String
            let mag: Double
            let time: Int
        }

        struct Geometry: Codable {
            let coordinates: [Double]
        }
    }
}

