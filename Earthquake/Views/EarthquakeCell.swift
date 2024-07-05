

import UIKit

class EarthquakeCell: UITableViewCell {
    static let identifier = "EarthquakeCell"
    
    private let infoLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    //special initializer for creating objects from Interface Builder
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        infoLabel.font = .systemFont(ofSize: 15)
        infoLabel.textColor = .black
        
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
    
    func configure(with earthquake: Earthquake) {
        infoLabel.text = "\(earthquake.place) - Mag: \(earthquake.magnitude)"
    }
}
