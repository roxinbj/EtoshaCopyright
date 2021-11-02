//
//  MyFonts.swift
//  Etoscha
//
//  Created by Björn Roxin on 21.04.21.
//

import Foundation

import UIKit

class MyFonts {
    
    static func getButtonFont(alignment:  NSTextAlignment) -> [NSAttributedString.Key : Any] {
       
        let paragraphstyle = NSMutableParagraphStyle()
        paragraphstyle.alignment = alignment
        
        let attributes : [NSAttributedString.Key: Any] = [
            .font: Appearance.semiBold,
            .paragraphStyle: paragraphstyle
            ]
        return attributes
    }

    static func getHeadingFont(alignment:  NSTextAlignment, size: CGFloat) -> [NSAttributedString.Key : Any] {
       
        let paragraphstyle = NSMutableParagraphStyle()
        paragraphstyle.alignment = alignment
        
        let attributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: Appearance.semiBold,
            .paragraphStyle: paragraphstyle
            ]
        return attributes
    }
    
    static func getTextFont(alignment: NSTextAlignment) -> [NSAttributedString.Key : Any] {
       
        let paragraphstyle = NSMutableParagraphStyle()
        paragraphstyle.alignment = alignment
        
        let attributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: Appearance.regular,
            .paragraphStyle: paragraphstyle
            ]
        return attributes
    }
}
