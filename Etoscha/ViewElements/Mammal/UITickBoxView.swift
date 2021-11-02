//
//  UITickBoxView.swift
//  Etoscha
//
//  Created by Björn Roxin on 06.04.21.
//

import UIKit

class UITickBoxView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    public var isTickBoxChecked : Bool = false{
        didSet{
            self.updateImage()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateImage()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        updateImage()
        self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
    }
    
    func updateImage(){
        if isTickBoxChecked {
            self.backgroundColor = .blue
        } else {
            self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height * 0.01
        self.layer.borderWidth = self.frame.height * 0.01
        self.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
}
