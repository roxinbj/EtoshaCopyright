//
//  FilterIcon.swift
//  Etoscha
//
//  Created by Björn Roxin on 05.12.20.
//

import UIKit

class FilterIcon: UIView {
   
    //------------------------
    //MARK: Private Functions
    //------------------------
    private func createCirclPath() -> UIBezierPath {
        let path = UIBezierPath(ovalIn: bounds)
        path.close()
        return path
    }
    
    private func createFilterIconPath() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: filterTopLeft)
        path.addLine(to: filterTopRight)
        path.addLine(to: filterMiddleRight)
        path.addLine(to: filterBottomRight)
        path.addLine(to: filterBottomLeft)
        path.addLine(to: filterMiddleLeft)
        path.addLine(to: filterTopLeft)
        path.close()
        return path
    }

    
//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect){
        // Drawing code
        //self.layer.backgroundColor = nil
        let circleLayer = CAShapeLayer()
        circleLayer.path = createCirclPath().cgPath
        circleLayer.fillColor = nil
        circleLayer.strokeColor = DrawSettings.strokeColor
        circleLayer.lineWidth = strokeSize
        circleLayer.shadowColor = DrawSettings.shadowColor
        circleLayer.shadowRadius = DrawSettings.shadowRadius
        circleLayer.shadowOpacity = DrawSettings.circleShadowOpacity
        self.layer.addSublayer(circleLayer)
        
        let iconLayer = CAShapeLayer()
        iconLayer.path = createFilterIconPath().cgPath
        iconLayer.strokeColor = DrawSettings.strokeColor
        iconLayer.fillColor = DrawSettings.fillColor
        iconLayer.backgroundColor = nil
        iconLayer.lineWidth = strokeSize
        iconLayer.bounds = iconBounds
        iconLayer.position = iconOrigin
        self.layer.addSublayer(iconLayer)
    }

}

extension FilterIcon {
    //MARK: Settings
    private struct SizeSettings {
        static var sideMargin : CGFloat = 0.05
        static var topPadding : CGFloat = 0.15
        static var bottomPadding : CGFloat = 0.05
        static var middleOfFilterHeightFactor : CGFloat = 0.4
        static var topOfFilterOutletHeightFactor : CGFloat = 0.8
        static var middleOfFilterWidthFactor : CGFloat = 0.4
    }
    
    private struct DrawSettings {
        static var strokeFactor : CGFloat = 0.04
        static var strokeColor : CGColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        static var fillColor : CGColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        static var backgroundColor : CGColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        static var shadowColor : CGColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1).cgColor
        static var circleShadowOpacity : Float = 0.15
        static var shadowRadius : CGFloat = 1.0
    }
    
    private var iconSideLength : CGFloat {
        return CGFloat(bounds.width * sqrt(2) / 2)
    }
    
    private var iconOrigin : CGPoint {
        return CGPoint(x: bounds.minX + bounds.width/2 ,
                       y: bounds.minY + bounds.height/2)
    }
    
    private var iconBounds : CGRect {
        return CGRect(x: 0,
                      y: 0,
                      width: iconSideLength,
                      height: iconSideLength)
    }
    
    private var filterTopLeft : CGPoint {
        return CGPoint(x: iconBounds.width*SizeSettings.sideMargin,
                       y: iconBounds.height*SizeSettings.topPadding)
    }
    
    private var filterTopRight :  CGPoint {
        return CGPoint(x: iconBounds.width*(1-SizeSettings.sideMargin),
                       y: iconBounds.height*SizeSettings.topPadding)
    }

    private var filterMiddleLeft : CGPoint {
        return CGPoint(x: iconBounds.width*SizeSettings.middleOfFilterWidthFactor,
                       y: iconBounds.height*SizeSettings.middleOfFilterHeightFactor)
    }
    
    private var filterMiddleRight : CGPoint {
        return CGPoint(x: iconBounds.width*(1-SizeSettings.middleOfFilterWidthFactor),
                       y: iconBounds.height*SizeSettings.middleOfFilterHeightFactor)
    }
    
    private var filterBottomLeft : CGPoint {
        return CGPoint(x: iconBounds.width*SizeSettings.middleOfFilterWidthFactor,
                       y: iconBounds.height*SizeSettings.topOfFilterOutletHeightFactor)
    }
    
    private var filterBottomRight : CGPoint {
        return CGPoint(x: iconBounds.width*(1-SizeSettings.middleOfFilterWidthFactor),
                       y: iconBounds.height*(1-SizeSettings.bottomPadding))
    }
    
    private var strokeSize :CGFloat {
        return bounds.height*DrawSettings.strokeFactor
    }
    
}

extension CGPoint {
    func offsetBy(_ point :CGPoint) -> CGPoint{
        return CGPoint(x: self.x + point.x, y: self.y + point.y)
    }
}
