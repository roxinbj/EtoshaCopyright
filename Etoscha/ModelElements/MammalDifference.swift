//
//  MammalDifference.swift
//  Etoscha
//
//  Created by Björn Roxin on 27.07.21.
//

import Foundation
import CoreGraphics

enum MammalDifference : String, CardAble {
    
    case LeopardCheetah
    case BlackWhiteRhino
    case SteenbokDikdikDuiker
    
    var animals : [MammalType] {
        switch self {
        case .LeopardCheetah: return [.leopard, .cheetah]
        case .BlackWhiteRhino: return [.blackRhino, .whiteRhino]
        case .SteenbokDikdikDuiker: return [.steenbok, .damaraDikDik, .commonDuiker]
        }
    }
    
    var image : [String] {
        switch self {
        case .LeopardCheetah: return [MammalType.leopard.transparentImages[1].0,MammalType.cheetah.transparentImages[1].0 ]
        case .BlackWhiteRhino: return [MammalType.blackRhino.transparentImages[1].0,MammalType.whiteRhino.transparentImages[1].0 ]
        case .SteenbokDikdikDuiker: return [MammalType.steenbok.transparentImages[1].0,MammalType.damaraDikDik.transparentImages[1].0,MammalType.commonDuiker.transparentImages[1].0 ]
        }
    }
    
    var diffCoordinates : [[CGPoint]] {
        var returnedValue = [[CGPoint]]()
        for animal in animals{
            returnedValue.append(animal.diffCoordinates ?? [])
        }
        return returnedValue
    }
    var diffTexts : [[String]] {
        var returnedValue = [[String]]()
        for animal in animals{
            returnedValue.append(animal.differences ?? [])
        }
        return returnedValue
    }
    
    var shortName: String {
        return NSLocalizedString("SpotTheDifference", tableName: "Mammals", bundle: .main, value: ErrorHandler.localizedStringNotFound, comment: "Mammals")
    }
    
    var mainImage: String {
        switch self {
        case .LeopardCheetah: return "Comparison/LeopardCheetah"
        case .BlackWhiteRhino: return "Comparison/BlackWhiteRhino"
        case .SteenbokDikdikDuiker: return "Comparison/SteenbokDuikerDikdik"
        }
    }
}
