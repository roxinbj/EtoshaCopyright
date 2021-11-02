//
//  DotsView.swift
//  Etoscha
//
//  Created by Björn Roxin on 26.04.21.
//

import UIKit

class DotsView: UIView {
    
    private var dotsContainerView : UIStackView?
    private let numberOfDots : Int
    
    var activeDot : Int = 0{
        didSet{
            if dotsContainerView != nil, dotsContainerView!.arrangedSubviews.count >= activeDot{
                for dot in dotsContainerView!.arrangedSubviews{
                    dot.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                }
                dotsContainerView!.arrangedSubviews[activeDot].backgroundColor = UIColor.white
                setNeedsDisplay()
                setNeedsLayout()
            }
        }
    }
    
    init(frame: CGRect, numberOfDots number: Int) {
        self.numberOfDots = number
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        setupDots()
    }
    
    required init?(coder: NSCoder) {
        self.numberOfDots = 0
        super.init(coder: coder)
    }
   
    private func setupDots() {
        var dots = [Dot]()
        for _ in 1...self.numberOfDots{
            let newDot = Dot()
            newDot.translatesAutoresizingMaskIntoConstraints = false
            newDot.heightAnchor.constraint(equalTo: newDot.widthAnchor).isActive = true
            newDot.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            newDot.layer.borderWidth = 1//dot.frame.height / 8.0
            newDot.layer.borderColor = UIColor.white.cgColor
            newDot.clipsToBounds = true
            
            dots.append(newDot)
        }
        
        dotsContainerView = getStackView(for: dots, with: .horizontal, spacing: 2)
        dotsContainerView!.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(dotsContainerView!)
        
        dotsContainerView!.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        dotsContainerView!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}

class Dot : UIView{
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.layer.borderWidth = 1//dot.frame.height / 8.0
//        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.frame.size.width * 0.5
    }
}

class roundedCorners : UIView {
    var cornerRadius : CGFloat?
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = cornerRadius ?? 0
    }
}
