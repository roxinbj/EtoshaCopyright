//
//  Habitat.swift
//  Etoscha
//
//  Created by Björn Roxin on 19.07.21.
//

import Foundation

enum Habitat : String ,NamedIcon{
    case wideRange = "Widespread"
    case reedbed = "Reedbed and floodplain"
    case bushveld = "Bushveld and savannah"
    case urbanArea = "Urban area"
    case desert = "Desert"
    case semiDesert = "Semi Desert"
    case rockyArea = "Rocky Area"
    case dryScrub = "Dry Scrub"
    case mountain = "Mountain and Hills"
    case forest = "Forest"
    case riverlineForests =  "Riverline Forests"
    case woodland = "Woodland"
    case grassPlains = "GrassPlains"
    
    var image : String{
        switch self {
        case .wideRange: return "Widespread"
        case .reedbed: return "ReedbedAndFloodplain"
        case .bushveld: return "Savannah"
        case .urbanArea: return "UrbanArea"
        case .desert: return  "Desert"
        case .semiDesert: return  "SemiDesert"
        case .rockyArea: return  "RockyArea"
        case .dryScrub: return  "Thicket"
        case .mountain: return  "Mountain"
        case .forest: return  "Forest"
        case .riverlineForests: return   "RiverlineForests"
        case .woodland: return  "Woodland"
        case .grassPlains: return  "Grassland"
        }
    }
    var name : String {
        return NSLocalizedString(self.rawValue, tableName: "Icons", bundle: .main, value: self.rawValue, comment: "Habitat")
    }}
