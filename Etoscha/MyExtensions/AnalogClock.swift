//
//  AnalogClockView.swift
//  Etoscha
//
//  Created by Björn Roxin on 26.05.21.
//


import Foundation
import UIKit

class AnalogClockView: UIView {
    
    //MARK: Views and layers
    private var imageView = UIImageView()
    private var hourLayer = CAShapeLayer()
    private var minuteLayer = CAShapeLayer()
    
    
    //MARK: Data
    public var date : Date = Date() {
        didSet{
            setTime()
            setNeedsLayout()
            setNeedsDisplay()
        }
    }
    
    private enum Hand {
        case hour
        case minute
    }
    
    private func getEndPoint(to hand: Hand) -> CGPoint{
        var angle = minuteAngle
        var length = length
        if hand == .hour {
            angle = hourAngle
            length = length * 0.6
        }
        let xPos = sin(angle)*length
        let yPos = -cos(angle)*length
        return CGPoint(x: xPos, y: yPos)
    }
    
    private var length : CGFloat {
        return self.frame.width/2 * 0.8
    }
   
    private var iconOrigin : CGPoint {
        return CGPoint(x: bounds.minX + bounds.width/2 ,
                       y: bounds.minY + bounds.height/2)
    }
    
    private var hourAngle : CGFloat{
        let hour : CGFloat = CGFloat(Calendar.current.dateComponents([.hour, .minute], from: self.date).hour!)
        let minute : CGFloat = CGFloat(Calendar.current.dateComponents([.hour, .minute], from: self.date).minute!)

        let hourMultiplicator : CGFloat = (360/12)
        let minuteMultiplicator : CGFloat = (1.0/60) * (360/12)
        let hourAngle = hour * hourMultiplicator + minute * minuteMultiplicator
        return hourAngle * CGFloat.pi / 180
    }
    private var minuteAngle : CGFloat{
        let minute : CGFloat = CGFloat(Calendar.current.dateComponents([.hour, .minute], from: self.date).minute!)
        let minuteMultiplicator : CGFloat = (360/60)
        let minuteAngle = minute * minuteMultiplicator
        return minuteAngle * CGFloat.pi / 180
    }
    
    //MARK: Set Clock functions
    private func setTime(){
        // Remove Layers
        if imageView.layer.sublayers != nil {
            for layer in imageView.layer.sublayers!{
                layer.removeFromSuperlayer()
            }
        }
        
        //add Hour Layer
        drawLineFromPoint(start: CGPoint(x: 0, y: 0), toPoint: getEndPoint(to: .hour), ofColor: .blue, inlayer: hourLayer)
        drawLineFromPoint(start: CGPoint(x: 0, y: 0), toPoint: getEndPoint(to: .minute), ofColor: .red, inlayer: minuteLayer)
    }
    
    private func drawLineFromPoint(start : CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor, inlayer layer:CAShapeLayer){
        //design the path
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        path.close()
       
        //design path in layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)
        shapeLayer.position = iconOrigin
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = 5.0
        imageView.layer.addSublayer(shapeLayer)
    }
    
    //MARK: Init methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupLayers()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension AnalogClockView {
    //MARK: Setup Functions
    private func setupImageView(){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        imageView.image = UIImage(named: "AnalogClock")
    }
    
    private func setupLayers(){
        //design path in layer
        hourLayer.anchorPoint = CGPoint(x: 0, y: 0)
        hourLayer.position = iconOrigin
        hourLayer.strokeColor = UIColor.blue.cgColor
        hourLayer.lineWidth = 3.0
        self.layer.addSublayer(hourLayer)
        
        //design path in layer
        minuteLayer.anchorPoint = CGPoint(x: 0, y: 0)
        minuteLayer.position = iconOrigin
        minuteLayer.strokeColor = UIColor.red.cgColor
        minuteLayer.lineWidth = 3.0
        self.layer.addSublayer(minuteLayer)
    }
}
