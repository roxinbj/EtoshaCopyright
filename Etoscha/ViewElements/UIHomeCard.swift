//
//  UIHomeCard.swift
//  Etoscha
//
//  Created by Björn Roxin on 18.04.21.
//

import UIKit

class UIHomeCard: UIView {
    
    // Constants
    private let cornerRadiusHeightRatio : CGFloat = 0.2
    private let gradientOpacity : Float = 0.4
    private let textOffsetLeftToWidthRatio : CGFloat = 0.08
    private let textOffsetBottomToHeightRatio : CGFloat = 0.04
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        
    }

    var image : UIImage? {
        didSet{
            if image != nil {
                imageView.image = image
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
    
    private lazy var imageView : UIImageView = {
        let myImageView = UIImageView(frame: self.bounds)
        myImageView.contentMode = .scaleAspectFill
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myImageView.clipsToBounds = true
        myImageView.layer.cornerRadius = myImageView.frame.height * cornerRadiusHeightRatio
        return myImageView
    }()
    
    private lazy var textView : UILabel =  {
       let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.adjustsFontForContentSizeCategory = true
        return textView
    }()
    
    private lazy var blurEffect : UIVisualEffectView = {
        let blur = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blur)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    private lazy var gradientLayer : CAGradientLayer =  {
        let frame = CGRect(x: self.bounds.minX, y: self.bounds.midY, width: self.bounds.width, height: self.bounds.height/2)
        let gradientlayer = CAGradientLayer()
        gradientlayer.colors = [ #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor,#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor]
        gradientlayer.opacity = gradientOpacity
        gradientlayer.frame = frame
        return gradientlayer
    }()
    

    func setupViews(){
        //addSubview(blurEffect)
        addSubview(imageView)
        imageView.layer.addSublayer(gradientLayer)
        addSubview(textView)
    }
    
    func setupConstraints(){
        let offsetX : CGFloat = self.bounds.height * textOffsetBottomToHeightRatio
        let offsetY : CGFloat = self.bounds.width * textOffsetLeftToWidthRatio
        textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: offsetY).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -offsetX).isActive = true
    
        NSLayoutConstraint.activate(imageView.constraintsForAnchoringTo(boundsOf: self))
    
//        blurEffect.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        blurEffect.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
    
    private func setTitle(with text: String){
        
        let paragraphstyle = NSMutableParagraphStyle()
        paragraphstyle.alignment = .center
        
        let attributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFontMetrics(forTextStyle: .title1).scaledFont(for: UIFont(name: Appearance.semiBold, size: 18)!),
            .paragraphStyle: paragraphstyle
            ]
        let attributedString = NSAttributedString(string: text, attributes: attributes)
       
        textView.attributedText = attributedString
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
