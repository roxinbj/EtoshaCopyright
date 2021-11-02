//
//  CardCollectionItem.swift
//  Etoscha
//
//  Created by Björn Roxin on 27.05.21.
//

import UIKit

class CardCollectionItem: UICollectionViewCell {
    static let reuseIdentifer = "album-item-cell-reuse-identifier"
    private let featuredPhotoView : UIImageView = {
        let tv = UIImageView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    private let titleView : UILabel = {
        let tv = UILabel()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    private let gradientView : GradientView = {
        let tv = GradientView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withImageName imageName: String, title: String, asSmallCard: Bool) {
        setImage(withImage: imageName)
        setTitle(with: title, smallFont: asSmallCard)
    }
    
    private func setupViews(){
        self.addSubview(featuredPhotoView)
        self.addSubview(titleView)
        self.addSubview(gradientView)
        self.bringSubviewToFront(titleView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            featuredPhotoView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            featuredPhotoView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            featuredPhotoView.topAnchor.constraint(equalTo: self.topAnchor),
            featuredPhotoView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Appearance.spacing),
            titleView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleView.heightAnchor.constraint(greaterThanOrEqualTo: self.heightAnchor, multiplier: 0.3),
            titleView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            gradientView.topAnchor.constraint(equalTo: titleView.topAnchor, constant: -30),
            gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    private func setImage(withImage name : String){
        featuredPhotoView.image = UIImage(named: name)
        featuredPhotoView.contentMode = .scaleAspectFill
    }
    
    private func setTitle(with title : String, smallFont: Bool){
        var font = Appearance.cardFontSmall?.withSize(26)
        let fontMetric = UIFontMetrics(forTextStyle: .title1)
        if smallFont{
            font = font?.withSize(20)
        }
        
        let attributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: fontMetric.scaledFont(for: font!),
            .paragraphStyle: Appearance.paragraphStyle
        ]
        let attributedString = NSAttributedString(string: title, attributes: attributes)
        titleView.attributedText = attributedString
        titleView.numberOfLines = 2
        titleView.lineBreakMode = .byWordWrapping
        titleView.textAlignment = NSTextAlignment.left
    }
}

class GradientView: UIView {
    
    override public class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }
    
    func setColors(first: CGColor, second: CGColor, opacity: Float){
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        gradientLayer.colors = [
             first,second
        ]
        gradientLayer.opacity = opacity
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        gradientLayer.colors = [
             #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor,#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        ]
        gradientLayer.opacity = 0.5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Card: UIView {
    static let reuseIdentifer = "album-item-cell-reuse-identifier"
    private let featuredPhotoView : UIImageView = {
        let tv = UIImageView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    private let titleView : UILabel = {
        let tv = UILabel()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    private let gradientView : GradientView = {
        let tv = GradientView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withImageName imageName: String, title: String, asSmallCard: Bool) {
        setImage(withImage: imageName)
        setTitle(with: title, smallFont: asSmallCard)
    }
    
    private func setupViews(){
        self.addSubview(featuredPhotoView)
        self.addSubview(titleView)
        self.addSubview(gradientView)
        self.bringSubviewToFront(titleView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            featuredPhotoView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            featuredPhotoView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            featuredPhotoView.topAnchor.constraint(equalTo: self.topAnchor),
            featuredPhotoView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleView.heightAnchor.constraint(greaterThanOrEqualTo: self.heightAnchor, multiplier: 0.3),
            titleView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            gradientView.topAnchor.constraint(equalTo: titleView.topAnchor, constant: -30),
            gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    private func setImage(withImage name : String){
        featuredPhotoView.image = UIImage(named: name)
        featuredPhotoView.contentMode = .scaleAspectFill
    }
    
    private func setTitle(with title : String, smallFont: Bool){
        let paragraphstyle = NSMutableParagraphStyle()
        paragraphstyle.alignment = .left
        
        var font = Appearance.cardFontSmall?.withSize(30)
        let fontMetric = UIFontMetrics(forTextStyle: .title1)
        if smallFont{
            font = font?.withSize(20)
        }
        
        let attributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: fontMetric.scaledFont(for: font!),
            .paragraphStyle: paragraphstyle
        ]
        let attributedString = NSAttributedString(string: title, attributes: attributes)
        titleView.attributedText = attributedString
        titleView.numberOfLines = 0
        titleView.sizeToFit()
        titleView.textAlignment = NSTextAlignment.left
    }
}
