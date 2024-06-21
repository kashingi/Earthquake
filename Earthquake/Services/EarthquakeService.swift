//
//  EarthquakeService.swift
//  Earthquake
//
//  Created by EMTECH MAC on 20/06/2024.
//

import Foundation

import Combine

class EarthquakeService {
    private let baseURL = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson"
    
    func fetchEarhquakes() -> AnyPublisher<[Earthquake], Error> {
        guard let url = URL(string: baseURL) else {
            fatalError("The URL used is invalid")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{ $0.data }
            .decode(type: EarthquakeResponse.self, decoder: JSONDecoder())
            .map { $0.earthquakes }
            .eraseToAnyPublisher()
    }
}
