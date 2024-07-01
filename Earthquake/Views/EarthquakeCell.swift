//
//  EarthquakeCell.swift
//  Earthquake
//
//  Created by EMTECH MAC on 28/06/2024.
//

import UIKit

class EarthquakeCell: UITableViewCell {
    static let identifier = "EarthquakeCell"
    
    private let placeLabel = UILabel()
    private let magnitudeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        placeLabel.font = .systemFont(ofSize: 16)
        magnitudeLabel.font = .systemFont(ofSize: 16)
        
        let stackView = UIStackView(arrangedSubviews: [placeLabel, magnitudeLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with earthquake: Earthquake) {
        placeLabel.text = earthquake.place
        magnitudeLabel.text = "Mag: \(earthquake.magnitude)"
    }
}
