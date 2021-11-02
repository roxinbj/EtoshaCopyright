//
//  Accommodation.swift
//  Etoscha
//
//  Created by Björn Roxin on 22.04.21.
//

import Foundation
import CoreGraphics

enum Accommodations : String, CardAble, CaseIterable{
    case Halali
    case Okaukuejo
    case Namutoni
    case Onkoshi
    case Dolomite
    case Olifantsrus
    
    var shortName: String {
        return self.rawValue
    }
    var telephone : String {
        switch self {
        case .Okaukuejo: return "067-229 800"
        case .Halali: return "067-229 400"
        case .Dolomite: return "065-685 119"
        case .Namutoni: return "067-229 300"
        case .Onkoshi: return "085-5502 342"
        case .Olifantsrus: return "061-285 7200"
        }
    }
    
    var mainImage: String {
        images.first!
    }
    
    var images : [String] {
        let baseName = self.rawValue
        var numbers = [Int]()
        switch self {
        case .Okaukuejo: numbers = [4,5,2,3]
        case .Namutoni: numbers = [1,2,3]
        case .Halali: numbers = [1,2,3]
        case .Dolomite: numbers = [3,4]
        case .Onkoshi: numbers = [1,2,3]
        case .Olifantsrus: numbers = [6,5,7,4]
        }
        var images = [String]()
        for number in numbers{
            images.append(baseName + "0" + String(number))
        }
        return images
    }
    
    var description : String {
        let regex = self.rawValue + "_Info"
        let locString = NSLocalizedString(regex, tableName: "Texts", bundle: .main, value: ErrorHandler.localizedStringNotFound, comment: "CampInfo")
        return locString
    }
    
    var accommodationText : String {
        let regex = self.rawValue + "_Accommodations"
        let locString = NSLocalizedString(regex, tableName: "Texts", bundle: .main, value: ErrorHandler.localizedStringNotFound, comment: "CampInfo")
        return locString
    }
    
    var url : String {
        switch self {
        case .Okaukuejo: return "https://www.nwr.com.na/resorts/okaukuejo-resort/"
        case .Halali: return "https://www.nwr.com.na/resorts/halali-resort/"
        case .Namutoni: return "https://www.nwr.com.na/resorts/namutoni-resort/"
        case .Dolomite: return "https://www.nwr.com.na/resorts/dolomite-resort/"
        case .Olifantsrus: return "https://www.nwr.com.na/resorts/olifantsrus-campsite/"
        case .Onkoshi: return "https://www.nwr.com.na/resorts/onkoshi-resort/"
        }
    }
    
    var email: String {
        return "reservations@nwr.com.na"
    }
    
    var facilities : [Facilities] {
        switch self {
        case .Okaukuejo: return [.restaurant,.curioShop,.gameDrives,.petrol,.swimmingPool,.waterhole,.kiosk,.groceryShop]
        case .Halali: return [.restaurant,.curioShop,.gameDrives,.petrol,.swimmingPool,.waterhole,.kiosk,.groceryShop]
        case .Namutoni: return [.restaurant,.curioShop,.gameDrives,.petrol,.swimmingPool,.waterhole,.kiosk,.groceryShop]
        case .Dolomite: return [.restaurant,.curioShop,.gameDrives,.swimmingPool,.waterhole]
        case .Olifantsrus: return [.waterhole,.kiosk]
        case .Onkoshi: return [.gameDrives,.restaurant,.curioShop,.swimmingPool]
        }
    }
    
    var coordinates : CGPoint {
        switch self {
        case .Dolomite : return CGPoint(x: 0.086, y: 0.459)
        case .Olifantsrus: return CGPoint(x: 0.202, y: 0.424)
        case .Okaukuejo: return CGPoint(x: 0.525, y: 0.555)
        case .Onkoshi: return CGPoint(x: 0.795, y: 0.216)
        case .Namutoni: return CGPoint(x: 0.865, y: 0.322)
        case .Halali: return CGPoint(x: 0.712, y: 0.472)
        }//Top Letft : 42 121   //Bottom right: 1750 996
        //width: 1708 height: 875
    }
}

