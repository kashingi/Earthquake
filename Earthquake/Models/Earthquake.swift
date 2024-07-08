//
//  Earthquake.swift
//  Earthquake
//
//  Created by EMTECH MAC on 20/06/2024.
//

//Add your imports here
import Foundation

// Define Earthquake model structure 
struct Earthquake: Codable {
    // Properties of the Earthquake struct
    let place: String
    let magnitude: Double
    let latitude: Double
    let longitude: Double
}
