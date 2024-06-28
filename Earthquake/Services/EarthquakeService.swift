//
//  EarthquakeService.swift
//  Earthquake
//
//  Created by EMTECH MAC on 20/06/2024.
//


import Foundation
import Combine

class EarthquakeService {
    func fetchEarthquakes() -> AnyPublisher<[Earthquake], Error> {
        let url = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: EarthquakeResponse.self, decoder: JSONDecoder())
            .map { response in
                response.features.map { feature in
                    Earthquake(
                        id: feature.id,
                        place: feature.properties.place,
                        magnitude: feature.properties.mag,
                        time: Date(timeIntervalSince1970: TimeInterval(feature.properties.time / 1000)),
                        latitude: feature.geometry.coordinates[1],
                        longitude: feature.geometry.coordinates[0]
                    )
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

