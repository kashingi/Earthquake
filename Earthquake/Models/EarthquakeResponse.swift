

//
//  EarthquakeResponse.swift
//  Earthquake
//
//  Created by EMTECH MAC on 28/06/2024.
//

import Foundation

// Define EarthquakeResponse model structure for decoding JSON response
struct EarthquakeResponse: Codable {
    let features: [Feature]

    // Nested Feature struct representing earthquake features
    struct Feature: Codable {
        // Properties of each earthquake feature
        let properties: Properties
        let geometry: Geometry
        let id: String

        // Nested Properties struct for earthquake properties
        struct Properties: Codable {
            // Properties of earthquake location and magnitude
            let place: String
            let mag: Double
            let time: Int
        }

        // Nested Geometry struct for earthquake coordinates
        struct Geometry: Codable {
            // Coordinates of the earthquake epicenter
            let coordinates: [Double]
        }
    }
}

