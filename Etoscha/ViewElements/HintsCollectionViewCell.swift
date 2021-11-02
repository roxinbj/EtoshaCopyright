//
//  HintsCollectionViewCell.swift
//  Etoscha
//
//  Created by Björn Roxin on 03.07.21.
//

import UIKit

class HintsCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifer = "hints-cell-reuse-identifier"
    
    private let titleView : UILabel = {
        let tv = UILabel()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    private let textView : UIView = {
        let tv = UIView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    private let textLabel : UILabel = {
        let tv = UILabel()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
   
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 5
        self.layer.borderColor = Appearance.primaryColor.cgColor
        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        self.layer.borderColor = Appearance.primaryColor.cgColor
        self.layer.masksToBounds = true
        self.backgroundColor = Appearance.backgroundColor
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, text: String) {
        let textParagraphstyle = NSMutableParagraphStyle()
        textParagraphstyle.alignment = .justified
        textParagraphstyle.hyphenationFactor = 1
        let screenSize: CGRect = UIScreen.main.bounds
        var fontsize : CGFloat = 14
        if screenSize.width > 320{
            fontsize = 16
        }
        let textAttributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: Appearance.black,
            .font: UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: Appearance.regular, size: fontsize)!),
            .paragraphStyle: textParagraphstyle
        ]
        textLabel.attributedText = NSAttributedString(string: text, attributes: textAttributes)
        textLabel.numberOfLines = 0
        textLabel.minimumScaleFactor = 0.5
    }
    
    private func setupViews(){
        self.addSubview(titleView)
        self.addSubview(textView)
        textView.addSubview(textLabel)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: self.topAnchor),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Appearance.padding/2),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Appearance.padding/2),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: Appearance.spacing/3),
            textLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: Appearance.padding/3),
            textLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -Appearance.padding/3),
            textLabel.bottomAnchor.constraint(equalTo: textView.bottomAnchor, constant: -Appearance.spacing/3)
        ])
    }
}
