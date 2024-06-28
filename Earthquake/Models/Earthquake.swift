//
//  Earthquake.swift
//  Earthquake
//
//  Created by EMTECH MAC on 20/06/2024.
//

import Foundation

struct Earthquake: Identifiable, Codable {
    let id: String
    let place: String
    let magnitude: Double
    let time: Date
    let latitude: Double
    let longitude: Double
}
