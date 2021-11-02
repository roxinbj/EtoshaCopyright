//
//  TrophyCollectionViewCell.swift
//  Etoscha
//
//  Created by Björn Roxin on 02.06.21.
//

import UIKit

class TrophyCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifer = "trophy-item-cell-reuse-identifier"
    var indexPath : IndexPath!
    var sightViewDelegate:SightDelegate!
    
    
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
    private let opagueView = UIView()

    @objc func handleDoubleClick(){
        sightViewDelegate.doubleTap(at: self.indexPath)
    }
    
    @objc func handleSingleClick(){
        sightViewDelegate.singleTap(at: indexPath)
    }
    
    @objc func longPressed(_ sender : UILongPressGestureRecognizer){
        if sender.state == .ended{
            handleDoubleClick()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        setupViews()
        setupConstraints()
        let doubleClick = UITapGestureRecognizer(target: self, action: #selector(handleDoubleClick))
        doubleClick.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleClick)

        let singleClick = UITapGestureRecognizer(target: self, action: #selector(handleSingleClick))
        singleClick.numberOfTapsRequired = 1
        self.addGestureRecognizer(singleClick)
        
        let longClick = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(_:)))
        self.addGestureRecognizer(longClick)
        
        singleClick.require(toFail: doubleClick)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withImageName imageName: String, title: String, index: IndexPath) {
        // Set index
        self.indexPath = index
        
        // Set Image
        featuredPhotoView.image = UIImage(named: imageName)
        featuredPhotoView.contentMode = .scaleAspectFill
        
        // Set Text
        let attributedString = NSAttributedString(string: title, attributes: Appearance.paragraphAttributes)
        titleView.attributedText = attributedString
    }
    func configure(withImage image: UIImage, title: String, index: IndexPath) {
        // Set index
        self.indexPath = index
        
        // Set Image
        featuredPhotoView.image = image
        featuredPhotoView.contentMode = .scaleAspectFill
        
        // Set Text
        let attributedString = NSAttributedString(string: title, attributes: Appearance.paragraphAttributes)
        titleView.attributedText = attributedString
    }
    
    func set(toOpague: Bool){
        if toOpague {
            featuredPhotoView.layer.opacity = 0.2
        }else {
            featuredPhotoView.layer.opacity = 1
        }
    }
    
    private func setupViews(){
        self.addSubview(featuredPhotoView)
        self.addSubview(titleView)
        self.bringSubviewToFront(titleView)
        self.addSubview(opagueView)
        
        featuredPhotoView.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        titleView.numberOfLines = 0
        titleView.lineBreakMode = .byWordWrapping
        //titleView.sizeToFit()
        titleView.textAlignment = NSTextAlignment.center
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            featuredPhotoView.topAnchor.constraint(equalTo: self.topAnchor),
            featuredPhotoView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            featuredPhotoView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
            featuredPhotoView.widthAnchor.constraint(equalTo: featuredPhotoView.heightAnchor, multiplier: 1)
        ])
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleView.topAnchor.constraint(equalTo: featuredPhotoView.bottomAnchor),
            //titleView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    private func setImage(withImage name : String){
        featuredPhotoView.image = UIImage(named: name)
    }
    
    private func setTitle(with title : String){
        
        let paragraphAttributes : [NSAttributedString.Key: Any] =
            [
                .foregroundColor: Appearance.black,
                .font: UIFontMetrics(forTextStyle: .title1).scaledFont(for: UIFont(name: Appearance.light, size: 12)!),
            ]
        let attributedString = NSAttributedString(string: title, attributes: paragraphAttributes)
        titleView.attributedText = attributedString
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        featuredPhotoView.layer.cornerRadius = featuredPhotoView.frame.height / 2
        featuredPhotoView.layer.masksToBounds = true
    }
}


protocol SightDelegate {
    func singleTap(at index: IndexPath)
    func doubleTap(at index: IndexPath)
}
