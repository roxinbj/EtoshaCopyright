//
//  FieldNoteTableViewCell.swift
//  Etoscha
//
//  Created by Björn Roxin on 16.07.21.
//

import UIKit

class FieldNoteTableViewCell: UITableViewCell {
    static let reuseIdentifier = "FieldNoteCell"
    private let dateFormatter : DateFormatter = {
        var df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy"
        return df
    }()
    
    //MARK: Views
    private var headingView = UILabel()
    private var textView = UILabel()
    private var dateView = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layer.cornerRadius = 5
        self.layer.borderColor = Appearance.primaryColor.cgColor
        self.layer.masksToBounds = true
        self.backgroundColor = Appearance.backgroundColor
        setupHeading()
        setupDate()
        setupText()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(heading: String, text: String, date: Date){
        //Heading
        setHeading(to: heading)
        //Text
        setText(to: text)
        //Date
        setDate(to:date)
    }
    
    private func setHeading(to heading: String){
        let paragraphstyle = NSMutableParagraphStyle()
        paragraphstyle.alignment = .left
        let attributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: Appearance.black,
            .font: UIFontMetrics(forTextStyle: .title1).scaledFont(for: UIFont(name: Appearance.semiBold, size: 18)!),
            .paragraphStyle: paragraphstyle
        ]
        let attributedString = NSAttributedString(string: heading, attributes: attributes)
        headingView.attributedText = attributedString
        headingView.numberOfLines = 1
        headingView.sizeToFit()
        headingView.textAlignment = NSTextAlignment.left
    }
    private func setText(to text: String){
        let textParagraphstyle = NSMutableParagraphStyle()
        textParagraphstyle.alignment = .left
        textParagraphstyle.hyphenationFactor = 1
        let textAttributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: Appearance.gray,
            .font: UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: Appearance.regular, size: 16)!),
            .paragraphStyle: textParagraphstyle
        ]
        textView.attributedText = NSAttributedString(string: text, attributes: textAttributes)
        textView.numberOfLines = 4
        textView.sizeToFit()
        textView.textAlignment = NSTextAlignment.left
    }
    private func setDate(to date: Date){
        let textParagraphstyle = NSMutableParagraphStyle()
        textParagraphstyle.alignment = .right
        let textAttributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: Appearance.gray,
            .font: UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: Appearance.regular, size: 16)!),
            .paragraphStyle: textParagraphstyle
        ]
        dateView.attributedText = NSAttributedString(string: dateFormatter.string(from: date), attributes: textAttributes)
        dateView.numberOfLines = 1
        dateView.sizeToFit()
        dateView.textAlignment = NSTextAlignment.right
    }
    
    
    private func setupHeading(){
        headingView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(headingView)
        NSLayoutConstraint.activate([
            headingView.topAnchor.constraint(equalTo: self.topAnchor, constant: Appearance.spacing/2),
            headingView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Appearance.padding/2)
        ])
    }
    private func setupText(){
        textView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: headingView.bottomAnchor, constant: Appearance.spacing/4),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Appearance.padding/2),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Appearance.padding/2),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Appearance.spacing/2)
        ])
    }
    private func setupDate(){
        dateView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(dateView)
        NSLayoutConstraint.activate([
            dateView.topAnchor.constraint(equalTo: self.topAnchor, constant: Appearance.spacing/2),
            dateView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Appearance.padding/2),
            //dateView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            dateView.bottomAnchor.constraint(equalTo: headingView.bottomAnchor, constant: -Appearance.spacing/2)
        ])
    }

}
