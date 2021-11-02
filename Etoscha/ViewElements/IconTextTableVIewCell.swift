//
//  IconTextTableVIewCell.swift
//  Etoscha
//
//  Created by Björn Roxin on 28.06.21.
//

import UIKit

class IconTextTableVIewCell: UICollectionViewCell {
    static let reuseIdentifier = "IconTextTableViewCell"
    private var nameLabel = UILabel()
    private var iconImageView = UIImageView()
    
    public func configure(image: String,name: String ){
        nameLabel.attributedText = NSAttributedString(string: name, attributes: Appearance.paragraphAttributes)
        iconImageView.image = UIImage(named: image)!.withTintColor(Appearance.primaryColor)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupIconImageView()
        setupNameView()
        self.backgroundColor = Appearance.backgroundColor
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupIconImageView(){
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconImageView)
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            //iconImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor),
            iconImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15)
        ])
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.clipsToBounds = true
    }
    private func setupNameView(){
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

}
