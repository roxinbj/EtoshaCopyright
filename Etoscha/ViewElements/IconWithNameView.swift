//
//  DietIconCollectionViewCell.swift
//  Etoscha
//
//  Created by Björn Roxin on 31.05.21.
//

import UIKit

class IconWithNameView: UIView {
    let featuredPhotoView = UIImageView()
    let titleView = UILabel()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    
        featuredPhotoView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withImageName imageName: String, title: String) {
        
        featuredPhotoView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(featuredPhotoView)

        NSLayoutConstraint.activate([
            featuredPhotoView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            featuredPhotoView.topAnchor.constraint(equalTo: self.topAnchor),
            featuredPhotoView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            featuredPhotoView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25)
        ])
        featuredPhotoView.contentMode = .scaleAspectFit
        featuredPhotoView.image = UIImage(named: imageName)?.withTintColor(Appearance.primaryColor)
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(titleView)
        NSLayoutConstraint.activate([
                    titleView.topAnchor.constraint(equalTo: self.topAnchor),
                    titleView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
                    titleView.leadingAnchor.constraint(equalTo: featuredPhotoView.trailingAnchor, constant: 0),
                    titleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
                ])
        
        let paragraphstyle = NSMutableParagraphStyle()
        paragraphstyle.alignment = .center
               
        let attributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: Appearance.black,
            .font: UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: Appearance.regular, size: 15)!),
            .paragraphStyle: paragraphstyle
        ]
        let attributedString = NSAttributedString(string: title, attributes: attributes)
        titleView.attributedText = attributedString
        titleView.numberOfLines = 0
        titleView.lineBreakMode = .byWordWrapping
        titleView.adjustsFontSizeToFitWidth = true
        titleView.minimumScaleFactor = 0.8
        //titleView.sizeToFit()
        titleView.textAlignment = NSTextAlignment.center
    }
}
