//
//  EarthquakeService.swift
//  Earthquake
//
//  Created by EMTECH MAC on 20/06/2024.
//

import Foundation
import Combine

class EarthquakeService {
    private let url = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson")!
    
    func fetchEarthquakes() -> AnyPublisher<[Earthquake], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: EarthquakeResponse.self, decoder: JSONDecoder())
            .map { response in
                response.features.map { feature in
                    Earthquake(
                        place: feature.properties.place,
                        magnitude: feature.properties.mag,
                        latitude: feature.geometry.coordinates[1],
                        longitude: feature.geometry.coordinates[0]
                    )
                }
            }
            .eraseToAnyPublisher()
    }
}
//
//struct EarthquakeResponse: Codable {
//    let features: [Feature]
//    
//    struct Feature: Codable {
//        let properties: Properties
//        let geometry: Geometry
//    }
//    
//    struct Properties: Codable {
//        let place: String
//        let mag: Double
//    }
//    
//    struct Geometry: Codable {
//        let coordinates: [Double]
//    }
//}

