//
//  TelefoneEntryViewCell.swift
//  Etoscha
//
//  Created by Björn Roxin on 28.06.21.
//

import UIKit

class TelefoneEntryCell: UITableViewCell {
    static let reuseIdentifer = "telefone-item-cell-reuse-identifier"
    let numberSize : CGFloat = 18
    let nameSize : CGFloat = 24
    var index : IndexPath!
    var phoneBookDelegate: PhoneBookDelegate!
   
    private let nameLabel = UILabel()
    private let numberLabel = UILabel()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func doubleTaped(){
        phoneBookDelegate.doubleClickEntry(for: index)
    }
    
    func configure(with name: String, tel number: String, color: UIColor = Appearance.black, index: IndexPath) {
        //set Index
        self.index = index
        
        // Set Name
        let nameParagraphstyle = NSMutableParagraphStyle()
        nameParagraphstyle.alignment = .left
               
        let nameAttributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: UIFontMetrics(forTextStyle: .title2).scaledFont(for: UIFont(name: Appearance.semiBold, size: 20)!),
            .paragraphStyle: nameParagraphstyle
        ]
        let attributedString = NSAttributedString(string: name, attributes: nameAttributes)
        nameLabel.attributedText = attributedString

        // Set Number
        let numberParagraphstyle = NSMutableParagraphStyle()
        numberParagraphstyle.alignment = .left
               
        let numberAttributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: Appearance.gray,
            .font: UIFontMetrics(forTextStyle: .title3).scaledFont(for: UIFont(name: Appearance.semiBold, size: 18)!),
            .paragraphStyle: numberParagraphstyle
        ]
        numberLabel.attributedText =  NSAttributedString(string: number, attributes: numberAttributes)
    }
    
    private func setupViews(){
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameLabel)
        nameLabel.textAlignment = .left
       
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(numberLabel)
        numberLabel.textAlignment = .left
        
        //add gesture
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTaped))
        doubleTapGesture.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTapGesture)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            nameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4)
        ])
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: self.topAnchor),
            numberLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            numberLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
}

protocol PhoneBookDelegate {
    func doubleClickEntry(for index: IndexPath)
}
