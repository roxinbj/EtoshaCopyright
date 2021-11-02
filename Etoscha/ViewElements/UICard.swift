//
//  UICard.swift
//  Etoscha
//
//  Created by Björn Roxin on 12.05.21.
//

import UIKit

class UICard: UIView {
    
    var delegate:UICardTarget?
    
    // Constants
    private let cornerRadius : CGFloat = 5
    private let gradientOpacity : Float = 0.5
    private let gradientHeight : CGFloat = 0.6
    private let textPaddingLeading : CGFloat = 20
    private let fontBigSizeWidthLimit : CGFloat = 150
    private let textPaddingBottom : CGFloat = 10
    private let gradientMaxAlphaColor : CGColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
    private let gradientMinAlphaColor : CGColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
    
    
    private var widthConstraint : NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        backgroundColor = .none
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
        backgroundColor = .none
        
    }
    
    var image : UIImage? {
        didSet{
            if image != nil {
                buttonView.setImage(image, for: .normal)
                layoutSubviews()
            }
        }
    }
    
    var title : String? {
        didSet{
            if title != nil {
                setTitle(with: title!)
            }
        }
    }
    
    var id : Int?
    
    @objc func touchButton() {
        delegate?.cardPressed(with: self.id)
    }
    
    private lazy var buttonView : UIButton = {
        let myImageView = UIButton(frame: self.bounds)
        myImageView.addTarget(nil, action: #selector(touchButton), for: .touchUpInside)
        myImageView.contentMode = .scaleAspectFill
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myImageView.clipsToBounds = true
        myImageView.layer.cornerRadius = cornerRadius
        return myImageView
    }()
    
    private lazy var textView : UILabel =  {
        let textView = UILabel()
        textView.adjustsFontForContentSizeCategory = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        //setTitle(with: title ?? "")
        return textView
    }()
    
    private lazy var gradientFrame : UIView = {
       let v = UIView()
        v.backgroundColor = .none
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = cornerRadius
        v.isUserInteractionEnabled = false
        return v
    }()
    
    private lazy var gradientLayer : CAGradientLayer =  {
        //let frame = CGRect(x: self.bounds.minX, y: self.bounds.midY, width: self.bounds.width, height: self.bounds.height*gradientHeight)
        let gradientlayer = CAGradientLayer()
        gradientlayer.colors = [gradientMinAlphaColor,gradientMaxAlphaColor]
        gradientlayer.opacity = gradientOpacity
        gradientlayer.cornerRadius = cornerRadius
        //gradientlayer.frame = frame
        return gradientlayer
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = gradientFrame.bounds
        var font = Appearance.cardFontSmall
        if self.frame.width > fontBigSizeWidthLimit {
            font = Appearance.cardFontBig
        }
        textView.font = font
    }
    

    func setupViews(){
        addSubview(buttonView)
        addSubview(gradientFrame)
        gradientFrame.layer.addSublayer(gradientLayer)
        addSubview(textView)
    }
    
    func setupConstraints(){
        textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: textPaddingLeading).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -textPaddingBottom).isActive = true
        
        gradientFrame.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gradientFrame.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        gradientFrame.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        gradientFrame.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: gradientHeight).isActive = true
        
        NSLayoutConstraint.activate(buttonView.constraintsForAnchoringTo(boundsOf: self))
            
    }
    
    private func setTitle(with text: String){

        let paragraphstyle = NSMutableParagraphStyle()
        paragraphstyle.alignment = .left
        
        var font = Appearance.cardFontSmall
        if self.frame.width > fontBigSizeWidthLimit {
            font = Appearance.cardFontBig
        }
        
        let attributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFontMetrics(forTextStyle: .largeTitle).scaledFont(for: font!),
            .paragraphStyle: Appearance.paragraphStyle
        ]
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        textView.attributedText = attributedString
        textView.numberOfLines = 0
        textView.lineBreakMode = .byClipping
        //textView.sizeToFit()
        textView.textAlignment = NSTextAlignment.left
    }

}

extension UICard {
    func setupCard(with data: (ViewNames, UIImage?), delegate: UICardTarget, id: Int?){
        self.image = data.1
        self.title = data.0.rawValue
        self.delegate = delegate
        self.id = id
    }
}

protocol UICardTarget {
    func cardPressed(with ID: Int?)
}
