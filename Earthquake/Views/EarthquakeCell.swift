

import UIKit

class EarthquakeCell: UITableViewCell {
    static let identifier = "EarthquakeCell"
    
    private let infoLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialize UI elements and constraints
        setupUI()
    }
    
    // Required initializer when using Interface Builder (not used here)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //implement setupUI() here
    private func setupUI() {
        infoLabel.font = .systemFont(ofSize: 15)
        infoLabel.textColor = .black
        
        // Add infoLabel to contentView and set up constraints
        contentView.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            infoLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            infoLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            infoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        contentView.backgroundColor = .white
    }
    
    // Configure cell with earthquake data
    func configure(with earthquake: Earthquake) {
        infoLabel.text = "\(earthquake.place) - Mag: \(earthquake.magnitude)"
    }
}

