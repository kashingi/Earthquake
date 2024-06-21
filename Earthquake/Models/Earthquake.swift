//
//  Earthquake.swift
//  Earthquake
//
//  Created by EMTECH MAC on 20/06/2024.
//

import Foundation

struct Earthquake: Decodable {
    let magnitude : Double
    let place : String
    let time : Date
    let coordinates : [Double]
    
    
    enum CodingKeys: String, CodingKey {
        case properties
        case geometry
    }
    
    enum PropertiesKeys: String, CodingKey {
        case magnitude = "mag"
        case place
        case time
    }
    
    enum GeomentryKeys: String, CodingKey {
        case coordinates
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let properties = try container.nestedContainer(keyedBy: PropertiesKeys.self, forKey: .properties)
        let geometry = try container.nestedContainer(keyedBy: GeomentryKeys.self, forKey: .geometry)
        
        magnitude = try properties.decode(Double.self, forKey: .magnitude)
        place = try properties.decode(String.self, forKey: .place)
        
        let timestamp = try properties.decode(Double.self, forKey: .time)
        
        time = Date(timeIntervalSince1970: timestamp / 1000)
        coordinates = try geometry.decode([Double].self, forKey: .coordinates)
    }
}
struct EarthquakeResponse: Decodable {
    let earthquakes: [Earthquake]
    
    enum CodingKeys: String, CodingKey {
        case features
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        earthquakes = try container.decode([Earthquake].self, forKey: .features)
    }
}
