//
//  Facilities.swift
//  Etoscha
//
//  Created by Björn Roxin on 19.07.21.
//

import Foundation

enum Facilities : String, CardAble, CaseIterable{
    case petrol = "Petrol"
    case restaurant = "Restaurant"
    case swimmingPool = "Swimming Pool"
    case groceryShop = "Grocery Shop"
    case curioShop = "Curio Shop"
    case waterhole = "Waterhole"
    case gameDrives = "Game Drives"
    case kiosk = "Kiosk"
    
    var shortName: String {
        return self.rawValue
    }
    var mainImage: String {
        switch self {
        case .curioShop: return "CurioShop"
        case .gameDrives: return "GameDrives"
        case .groceryShop: return "Shop"
        case .petrol: return "Fuel"
        case .restaurant: return "Restaurant"
        case .swimmingPool: return "SwimmingPool"
        case .waterhole: return "Waterhole"
        case .kiosk: return "Kiosk"
        }
    }
}
