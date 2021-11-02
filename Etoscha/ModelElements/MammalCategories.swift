//
//  MammalCategories.swift
//  Etoscha
//
//  Created by Björn Roxin on 19.07.21.
//

import Foundation

enum MammalCategories: String, CardAble, CaseIterable {
    case Cats
    case Giants
    case SmallMammals
    case HoofedLarge
    case HoofedSmall
    case Canines
    case Hyaenas
    case Mongoose
    case Hares
    case Squirrels
    case SmallCarnivores
    case Others
    
    
    var shortName : String {
        return getLocalizedString(to: self.rawValue) ?? self.rawValue
    }
    
    var mainImage : String {
        if let shownAnimal = self.containedMammals?[0] {
            return shownAnimal.mainImage
        }
        
        if let subCategory = self.subcategory?[0] {
            if let animal = subCategory.containedMammals?[0]{
                return animal.mainImage
            }
        }
        return "MammalsCard"
    }
    
    var containedMammals : [MammalType]? {
        switch self {
        case .Cats:
            return [.lion,.leopard,.cheetah,.caracal,.africanWildCat,.africanCivet,.serval,.smallSpottedCat]
        case .Giants:
            return [.africanElephant, .blackRhino, .whiteRhino]
        case .Canines:
            return [.blackBackedJackal,.batEaredFox,.sideStripedJackal,.capeFox]
        case .Hyaenas:
            return [.spottedHyaena,.brownHyaena,.aardwolf]
        case .HoofedLarge:
            return [.giraffe,.gemsbok,.greaterKudu,.burchellsZebra,.commonEland,.blueWildebeest,.redHartebeest,.hartmannsZebra]
        case .HoofedSmall:
            return [.springbok,.blackFacedImpala,.commonWarthog ,.steenbok, .damaraDikDik, .commonDuiker,.klipspringer]
        case .Mongoose:
            return [.bandedMongoose,.dwarfMongoose,.yellowMongoose,.slenderMongoose]
        case .Squirrels:
            return [.southAfricanGroundSquirrel,.treeSquirrel]
        case .Hares:
            return [.southAfricanSpringhare,.capeHare,.scrubHare]
        case .SmallCarnivores:
            return [.suricate,.honeyBadger,.smallSpottedGenet]
        case .Others:
            return [.capePorcupine,.aardvark,.groundPangolin,.rockDassie,.southAfricanHedgehog,.southernLesserGalago]
        default:
            return nil
        }
    }
    
    var subcategory : [MammalCategories]? {
        switch self {
        case .SmallMammals:
            return [.SmallCarnivores,.Hares,.Squirrels,.Mongoose,.Others]
        default:
            return nil
        }
    }
    
    var spotTheDiffernce : MammalDifference? {
        switch self {
        case .Cats: return .LeopardCheetah
        case .Giants: return .BlackWhiteRhino
        case .HoofedSmall: return .SteenbokDikdikDuiker
        default:
            return nil
        }
    }
    
    var underlyingMammalTypes : [MammalType]{
        if containedMammals != nil {
            return containedMammals!
        }
        guard subcategory != nil else {return [MammalType]()}
        
        var underlyingMammalTypes = [MammalType]()
        for cat in subcategory!{
            assert(cat.containedMammals != nil,"Should not contain double hyrarchy")
            underlyingMammalTypes += cat.containedMammals ?? [MammalType]()
        }
        return underlyingMammalTypes
    }
    func getLocalizedString(to regex: String) -> String?{
        let locString = NSLocalizedString(regex, tableName: "Mammals", bundle: .main, value: ErrorHandler.localizedStringNotFound, comment: "Mammals")
        if locString == ErrorHandler.localizedStringNotFound {
            return nil
        }
        return locString
    }
}
