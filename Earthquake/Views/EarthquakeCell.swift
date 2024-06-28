//
//  EarthquakeCell.swift
//  Earthquake
//
//  Created by EMTECH MAC on 28/06/2024.
//

import Foundation

import UIKit

class EarthquakeCell : UITableViewCell {
    
    static let identifier = "Earthquake in a Table"
    
    func configure(with earthquake : Earthquake) {
        
        textLabel?.text = "\(earthquake.place) - \(earthquake.magnitude)"
    }
}
