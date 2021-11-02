//
//  MammalTextView.swift
//  Etoscha
//
//  Created by Björn Roxin on 23.04.21.
//

import UIKit

class MammalProfileInfoView: UIView {
    
    var info : [(UIImage,String)]?{
        didSet{
            if info != nil {
                infoBox.arrangedSubviews.forEach({$0.removeFromSuperview()})
                for newInfo in info!{
                    let newRow = InfoBoxView()
                    //newRow.translatesAutoresizingMaskIntoConstraints = false
                    newRow.image = newInfo.0
                    newRow.text = newInfo.1
                    infoBox.addArrangedSubview(newRow)
                }
                setNeedsLayout()
                setNeedsDisplay()
            }
        }
    }
    
    private var infoBox : UIStackView = {
        let infoView = UIStackView()
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.axis = .vertical
        infoView.spacing = 10
        infoView.alignment = .fill

         return infoView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.isUserInteractionEnabled = true
        setupViews()
        setupConstraints()
    }
    
    
    private func setupViews() {
        addSubview(infoBox)
        bringSubviewToFront(infoBox)
    }

    private func setupConstraints() {
        infoBox.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        infoBox.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        infoBox.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true // TBR
    }
}


class InfoBoxView : UIView {
    
    private let imageSize : CGFloat = 25
    
    var text : String? {
        didSet{
            if text != nil {
                let paragraphstyle = NSMutableParagraphStyle()
                paragraphstyle.alignment = .left
                paragraphstyle.hyphenationFactor = 1
                let attributes : [NSAttributedString.Key: Any] = [
                    .foregroundColor: UIColor.white,
                    .font: UIFontMetrics(forTextStyle: .title1).scaledFont(for: UIFont(name: Appearance.semiBold, size: 18)!),
                    .paragraphStyle: paragraphstyle
                ]
                let attributedString = NSAttributedString(string: self.text!, attributes: attributes)
                infoText.attributedText = attributedString
                infoText.numberOfLines = 0
                infoText.sizeToFit()
                infoText.textAlignment = NSTextAlignment.left
            }
        }
    }
    var image : UIImage?{
        didSet{
            if image != nil {
                let tintedImage = image?.withRenderingMode(.automatic).withTintColor(UIColor.white)
                infoImage.image = tintedImage
            }
        }
    }
    
    private var infoImage : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
         return imageView
    }()
    
    private var infoText : UILabel =  {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.isUserInteractionEnabled = true
        setupViews()
        setupConstraints()
    }
    
    
    private func setupViews() {
        addSubview(infoImage)
        addSubview(infoText)
    }
    
    private func setupConstraints() {
        
        //NSLayoutConstraint.activate(infoImage.constraintsForAnchoringTo(boundsOf: self))
        infoImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        infoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        //infoImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        infoImage.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        infoImage.widthAnchor.constraint(equalTo: infoImage.heightAnchor).isActive = true

        infoText.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        infoText.leadingAnchor.constraint(equalTo: infoImage.trailingAnchor, constant: 20).isActive = true
        infoText.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        infoText.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }

}
