//
//  MammalsHeadingViewController.swift
//  Etoscha
//
//  Created by Björn Roxin on 19.06.21.
//

import UIKit

class MammalsHeadingViewController: UIViewController {
    //MARK: Constants
    private let spacing : CGFloat = 40
    private let padding : CGFloat = 20
    private let nameWidthRatio : CGFloat = 0.5
    private let nameHeightRatio : CGFloat = 0.2
    private let scienceNameWidthRatio : CGFloat = 0.4
    private let scienceNameHeightRatio : CGFloat = 0.2
    
    //MARK: Views
    private let nameView = UILabel()
    private let scienceNameView = UILabel()
    
    //MARK: Data
    
    //MARK: Load View
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Appearance.backgroundColor
        setupHeading()
        // Do any additional setup after loading the view.
    }
    
    func setHeading(name: String, scientificName scName: String) {
        var paragraphStype : NSMutableParagraphStyle {
            let paragraphstyle = NSMutableParagraphStyle()
            paragraphstyle.alignment = .left
            paragraphstyle.hyphenationFactor = 1
            return paragraphstyle
        }
        let rightAttributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: Appearance.gray,
            .font: UIFontMetrics(forTextStyle: .title1).scaledFont(for: UIFont(name: Appearance.semiBold, size: 18)!),
            .paragraphStyle: paragraphStype
        ]
        let leftAttributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: Appearance.black,
            .font: UIFontMetrics(forTextStyle: .title1).scaledFont(for: UIFont(name: Appearance.semiBold, size: 20)!),
            .paragraphStyle: paragraphStype
        ]
        
        nameView.attributedText = NSAttributedString(string: name, attributes: leftAttributes)
        nameView.numberOfLines = 0
        nameView.sizeToFit()
        nameView.textAlignment = NSTextAlignment.left
        
        scienceNameView.attributedText = NSAttributedString(string: scName, attributes: rightAttributes)
        scienceNameView.numberOfLines = 0
        scienceNameView.sizeToFit()
        scienceNameView.textAlignment = NSTextAlignment.left
    }
    
    private func setupHeading(){
        nameView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(nameView)
        NSLayoutConstraint.activate([
            nameView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            nameView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: spacing),
            nameView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: nameWidthRatio),
            nameView.heightAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.heightAnchor,multiplier: nameHeightRatio)
        ])
        nameView.numberOfLines = 0
        nameView.adjustsFontSizeToFitWidth = true
        nameView.minimumScaleFactor = 0.5
        
        scienceNameView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scienceNameView)
        NSLayoutConstraint.activate([
            scienceNameView.leadingAnchor.constraint(equalTo: nameView.trailingAnchor, constant: padding),
            scienceNameView.topAnchor.constraint(equalTo: nameView.topAnchor,constant: 0),
            scienceNameView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: scienceNameWidthRatio),
            scienceNameView.heightAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.heightAnchor,multiplier: scienceNameHeightRatio)
        ])
        scienceNameView.numberOfLines = 0
    }

}
