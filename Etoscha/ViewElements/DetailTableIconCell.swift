//
//  IconAndTextCollectionViewCell.swift
//  Etoscha
//
//  Created by Björn Roxin on 29.05.21.
//

import UIKit

class DetailTableIconCell: UICollectionViewCell {
    static let reuseIdentifer = "icon-and-text-reuse-identifier"
    let featuredPhotoView = UIImageView()
    let titleView = UILabel()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        featuredPhotoView.layer.cornerRadius = 5
        featuredPhotoView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 0.8
        contentView.layer.borderColor = Appearance.primaryColor.cgColor
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        featuredPhotoView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(featuredPhotoView)
        
        NSLayoutConstraint.activate([
            featuredPhotoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            featuredPhotoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            featuredPhotoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            featuredPhotoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            //featuredPhotoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            featuredPhotoView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.45)
        ])
        featuredPhotoView.contentMode = .scaleAspectFit
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleView)
        NSLayoutConstraint.activate([
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleView.heightAnchor.constraint(greaterThanOrEqualTo: contentView.heightAnchor, multiplier: 0.3),
            titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
        titleView.numberOfLines = 0
        titleView.sizeToFit()
        titleView.textAlignment = NSTextAlignment.center
    }
    
    func configure(withImageName imageName: String, title: String, asSelected: Bool) {
        
        let image = UIImage(named: imageName)
        var fontColor = Appearance.primaryColor
        var imageColor = Appearance.primaryColor
        var backgroundColor = Appearance.backgroundColor

        if asSelected {
            backgroundColor = Appearance.primaryColor
            fontColor = UIColor.white
            imageColor = UIColor.white
        }
        
        featuredPhotoView.image = image?.withRenderingMode(.alwaysOriginal).withTintColor(imageColor)
        contentView.backgroundColor = backgroundColor

        
        let paragraphstyle = NSMutableParagraphStyle()
        paragraphstyle.alignment = .center
               
        let attributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: fontColor,
            .font: UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: Appearance.semiBold, size: 14)!),
            .paragraphStyle: paragraphstyle
        ]
       
        let attributedString = NSAttributedString(string: title, attributes: attributes)
        titleView.attributedText = attributedString
    }
}
