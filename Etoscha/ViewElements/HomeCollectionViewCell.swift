//
//  HomeCollectionViewCell.swift
//  Etoscha
//
//  Created by Björn Roxin on 01.06.21.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifer = "home-cell-reuse-identifier"
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
    private let subtitleView : UILabel = {
        let tv = UILabel()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    private let gradientView : UIView = {
        let tv = UIView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    private var gradientLayer : CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor,#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor]
        gradientLayer.opacity = 0.4
        gradientLayer.frame = CGRect.zero
        return gradientLayer
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
    
    func configure(withImageName imageName: String, title: String, subtitle: String) {
        setImage(withImage: imageName)
        setTitle(with: title)
        setSubtitle(with: subtitle)
        self.bringSubviewToFront(titleView)
        self.bringSubviewToFront(subtitleView)
    }
    
    private func setupViews(){
        self.addSubview(featuredPhotoView)
        self.addSubview(titleView)
        self.addSubview(subtitleView)
        self.addSubview(gradientView)
        gradientView.layer.addSublayer(gradientLayer)
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
            //titleView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Appearance.padding),
            titleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Appearance.padding),
            titleView.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height * 1/3)
            //titleView.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height * 0.52)
        ])
        
        NSLayoutConstraint.activate([
            subtitleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Appearance.padding),
            subtitleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Appearance.padding),
            subtitleView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: titleView.topAnchor, constant: -20),
            gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    private func setImage(withImage name : String){
        featuredPhotoView.image = UIImage(named: name)
        featuredPhotoView.contentMode = .scaleAspectFill
    }
    
    private func setTitle(with title : String){
        let paragraphstyle = NSMutableParagraphStyle()
        paragraphstyle.alignment = .center
        
        let attributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFontMetrics(forTextStyle: .largeTitle).scaledFont(for: UIFont(name: Appearance.semiBold, size: 30)!),
            .paragraphStyle: paragraphstyle
        ]
        
        let attributedString = NSAttributedString(string: title, attributes: attributes)
        titleView.attributedText = attributedString
        titleView.numberOfLines = 0
        titleView.sizeToFit()
        titleView.textAlignment = NSTextAlignment.center
    }
    
    private func setSubtitle(with subtitle : String){
        let paragraphstyle = NSMutableParagraphStyle()
        paragraphstyle.alignment = .center
        let attributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: Appearance.primaryColor,
            .font: UIFontMetrics(forTextStyle: .title2).scaledFont(for: UIFont(name: Appearance.medium, size: 20)!),
            .paragraphStyle: paragraphstyle
        ]
        
        let attributedString = NSAttributedString(string: subtitle, attributes: attributes)
        subtitleView.attributedText = attributedString
        subtitleView.numberOfLines = 0
        subtitleView.sizeToFit()
        subtitleView.textAlignment = NSTextAlignment.left
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = gradientView.frame
    }
}

