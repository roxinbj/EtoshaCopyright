//
//  ImageContainer.swift
//  Etoscha
//
//  Created by Björn Roxin on 29.07.21.
//

import Foundation
import UIKit
import CoreGraphics


struct ImageManager {
    
    var mainImage : Int
    var images : [String]
    var faceRectInImage : [CGRect?]
}

struct FacedImage {
    var imageName : String
    var rect : CGRect?
    var croppedImage : UIImage? {
        var image = UIImage(named: imageName)?.cgImage
        if image != nil {
            return nil
        }
        if rect != nil{
            image = image!.cropping(to: rect!)
        }
        return UIImage(cgImage: image!)
    }
    
}

extension UIImage {
    func crop(with rect: CGRect)-> UIImage? {
        if let image = self.cgImage {
            return UIImage(cgImage: image.cropping(to: rect)!)
        }
        return nil
    }
}


struct LabeledImage {
    var imageName : String
    var shapes : [Shape]?
    var imageSize : CGSize?
    
    
    
}
struct Shape {
    var label : Label
    var points : [CGPoint]
    
    var rect : CGRect {
        return CGRect(x: self.points.first!.x, y: self.points.first!.y, width: self.width, height: self.height)
    }
    var width : CGFloat {
        return abs(points[1].x - points[0].x)
    }
    var height : CGFloat {
        return abs(points[1].y - points[0].y)
    }
    
    func getScaleFactor(tofit view: CGSize)-> CGFloat {
        let widthRatio = self.width/view.width
        let heightRatio = self.height/view.height
        
        let scaleFactor = 1/max(widthRatio, heightRatio)
        return scaleFactor
    }
    func getOffset(tofit view: CGSize)-> CGPoint {
        let viewMidX = view.width/2
        let viewMidY = view.height/2
        
        let selfMidX = self.points[0].x + self.width/2
        let selfMidY = self.points[0].y + self.height/2
        
        return CGPoint(x: viewMidX-selfMidX, y: viewMidY-selfMidY)
    }
    
    init?(json: [String: Any]) {
        guard let labelString = json["label"] as? String,
              let pointsJson = json["points"] as? [[CGFloat]]
        else {return nil}
        
        guard let label = Label(rawValue: labelString) else {return nil}
        self.label = label
        
        var newPoints = [CGPoint]()
        for point in pointsJson{
            guard pointsJson.count == 2 else {return nil}
            newPoints.append(CGPoint(x: point[0], y: point[1]))
        }
        self.points = newPoints
    }
}

enum Label :String{
    case CA
    case Face
}

extension LabeledImage {
    init?(json: [String: Any]) {
        guard let imagePathName = json["imagePath"] as? String,
              let shapeJson = json["shapes"] as? [Any],
              let imageHeight = json["imageHeight"] as? CGFloat,
              let imageWidth = json["imageWidth"] as? CGFloat
        else {return nil}
        
        var shapes = [Shape]()
        for shapeString in shapeJson{
            if let shapeJson = shapeString as? [String: Any],
            let shape = Shape(json: shapeJson) {
                shapes.append(shape)
            }
        }
        
        self.imageName = NSString(string: imagePathName).lastPathComponent
        self.shapes = shapes
        self.imageSize = CGSize(width: imageWidth, height: imageHeight)
    }
}

