//
//  Appearance.swift
//  Etoscha
//
//  Created by Björn Roxin on 20.04.21.
//

import UIKit


struct Appearance {
    
    // Colors
    static let backgroundColor : UIColor = #colorLiteral(red: 1, green: 0.9764705882, blue: 0.9607843137, alpha: 1)
    static let backgroundColorVaired : UIColor = #colorLiteral(red: 0.9396639466, green: 0.9144302011, blue: 0.9049177766, alpha: 1)
    static let primaryColor : UIColor = #colorLiteral(red: 0.7960784314, green: 0.5803921569, blue: 0.368627451, alpha: 1)
    static let secondaryColor : UIColor = #colorLiteral(red: 0.7764705882, green: 0.3607843137, blue: 0.231372549, alpha: 1)
    static let tertiaryColor : UIColor =  #colorLiteral(red: 0.6928141713, green: 0.5079553723, blue: 0.3240083456, alpha: 1)
    static let brightColor : UIColor = #colorLiteral(red: 0.9292697906, green: 0.1536737084, blue: 0, alpha: 1)
    static let black : UIColor = #colorLiteral(red: 0.2878275216, green: 0.2857527137, blue: 0.2894198895, alpha: 1)
    static let gray : UIColor = #colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1)
    static let lightGray : UIColor = #colorLiteral(red: 0.8922247887, green: 0.8869213462, blue: 0.8963019252, alpha: 1)

    // Fonts
    static let light = "Raleway-Light"
    static let semiBold = "Raleway-SemiBold"
    static let medium = "Raleway-Medium"
    static let bold = "Raleway-ExtraBold"
    static let regular = "Raleway"
    
    static let largeTitle = 30
    static let titleSize = 30
    
    static let titleFont = UIFont(name: "Raleway-SemiBold", size: 16)
    static let subheadingFont = UIFont(name: "Raleway-Medium", size: 16)
    static let cardFontSmall = UIFont(name: "Raleway-Medium", size: 24)
    static let cardFontBig = UIFont(name: "Raleway-Medium", size: 26)
    static let textFont = UIFont(name: "Raleway-Light", size: 18)

    
    //Dimensions
    static let spacing : CGFloat = 20
    static let padding : CGFloat = 20
    static let horizontalLineWidth : CGFloat = 1.5
    static let horizontalLineWidthRatio : CGFloat = 0.3
    
    static var paragraphStyle : NSMutableParagraphStyle {
        let ps = NSMutableParagraphStyle()
        //ps.alignment = NSTextAlignment.center
        ps.hyphenationFactor = 1
        return ps
    }
    
    static let paragraphAttributes : [NSAttributedString.Key: Any] =
        [
            .foregroundColor: Appearance.black,
            .font: UIFont(name: Appearance.regular, size: 16)!,
            .paragraphStyle: paragraphStyle
            
        ]
    static let subheadingAttributes : [NSAttributedString.Key: Any] =
        [
            .foregroundColor: Appearance.black,
            .font: UIFont(name: Appearance.semiBold, size: 16)!
        ]
    
    static func printFonts() {
        for family in UIFont.familyNames {

            let sName: String = family as String
            print("family: \(sName)")
                    
            for name in UIFont.fontNames(forFamilyName: sName) {
                print("name: \(name as String)")
            }
        }
    }
}
