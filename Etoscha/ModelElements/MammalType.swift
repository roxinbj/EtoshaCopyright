//
//  Animal.swift
//  Etoscha
//
//  Created by Björn Roxin on 10/11/20.
//  Copyright © 2020 Björn Roxin. All rights reserved.
//

import Foundation
import CoreGraphics

enum MammalType:String, CaseIterable, CardAble{
    
    case aardvark = "Aardvark"
    case aardwolf = "Aardwolf"
    case africanWildCat = "AfricanWildCat"
    case africanElephant = "AfricanElephant"
    case africanCivet = "AfricanCivet"
    case bandedMongoose = "BandedMongoose"
    case batEaredFox = "BatEaredFox"
    case blackBackedJackal = "BlackBackedJackal"
    case blackFacedImpala = "BlackFacedImpala"
    case blackRhino = "BlackRhino"
    case blueWildebeest = "BlueWildebeest"
    case brownHyaena = "BrownHyaena"
    case burchellsZebra = "BurchellsZebra"
    case capeFox = "CapeFox"
    case capeHare = "CapeHare"
    case capePorcupine = "CapePorcupine"
    case caracal = "Caracal"
    case cheetah = "Cheetah"
    case commonDuiker = "CommonDuiker"
    case commonEland = "CommonEland"
    case commonWarthog = "CommonWarthog"
    case damaraDikDik = "DamaraDikDik"
    case dwarfMongoose = "DwarfMongoose"
    case gemsbok = "Gemsbok"
    case giraffe = "Giraffe"
    case greaterKudu = "GreaterKudu"
    case groundPangolin = "GroundPangolin"
    case hartmannsZebra = "HartmannsZebra"
    case honeyBadger = "HoneyBadger"
    case klipspringer = "Klipspringer"
    case leopard = "Leopard"
    case lion = "Lion"
    case redHartebeest = "RedHartebeest"
    case rockDassie = "RockDassie"
    case scrubHare = "ScrubHare"
    case serval = "Serval"
    case sideStripedJackal = "SideStripedJackal"
    case slenderMongoose = "SlenderMongoose"
    case smallSpottedCat = "SmallSpottedCat"
    case smallSpottedGenet = "SmallSpottedGenet"
    case southAfricanGroundSquirrel = "SaGroundSquirrel"
    case southAfricanSpringhare = "SaSpringhare"
    case southAfricanHedgehog = "SaHedgehog"
    case southernLesserGalago = "SouthernLesserGalago"
    case spottedHyaena = "SpottedHyaena"
    case springbok = "Springbok"
    case steenbok = "Steenbok"
    case suricate = "Suricate"
    case treeSquirrel = "TreeSquirrel"
    case whiteRhino = "WhiteRhino"
    case yellowMongoose = "YellowMongoose"
    
    var shortName: String {
        let nameRegex = self.rawValue + "_ShortName"
        return getLocalizedString(to: nameRegex) ?? self.rawValue
    }
    
    var scientificName : String? {
        let nameRegex = self.rawValue + "_ScientificName"
        return getLocalizedString(to: nameRegex)
    }
    var longName: String {
        let nameRegex = self.rawValue + "_Name"
        return getLocalizedString(to: nameRegex) ?? self.rawValue
    }
    var funFacts : [String] {
        let funfactsRegex = self.rawValue + "_FunFact"
        let fact = getLocalizedString(to: funfactsRegex)
        let factsArray = fact?.components(separatedBy: "&") ?? [String]()
        return factsArray
    }
    
    var etoshaFact : String? {
        let nameRegex = self.rawValue + "_Etosha"
        return getLocalizedString(to: nameRegex)
    }
    var firstExtraFact : String? {
        let nameRegex = self.rawValue + "_FirstExtra"
        return getLocalizedString(to: nameRegex)
    }
    var firstExtraFactHeading : String? {
        let nameRegex = self.rawValue + "_FirstExtraHeading"
        return getLocalizedString(to: nameRegex)
    }
    
    var conservationStatus : String? {
        let nameRegex = self.rawValue + "_ConservationStatus"
        return getLocalizedString(to: nameRegex)
    }
    
    var sizeDescription : String? {
        let nameRegex = self.rawValue + "_SizeDescription"
        return getLocalizedString(to: nameRegex)
    }
    
    var socialBehavior : String? {
        let nameRegex = self.rawValue + "_SocialBehavior"
        return getLocalizedString(to: nameRegex)
    }
    var behavior : String? {
        let nameRegex = self.rawValue + "_Behaviour"
        return getLocalizedString(to: nameRegex)
    }
    var raisingCalves : String? {
        let nameRegex = self.rawValue + "_RaisingCalves"
        return getLocalizedString(to: nameRegex)
    }
    
    var appearance : String? {
        let nameRegex = self.rawValue + "_Appearance"
        return getLocalizedString(to: nameRegex)
    }
    
    var genderDiff : String? {
        let nameRegex = self.rawValue + "_GenderDiff"
        return getLocalizedString(to: nameRegex)
    }
    var dietText : String? {
        let nameRegex = self.rawValue + "_Diet"
        return getLocalizedString(to: nameRegex)
    }
    var predators : String? {
        let nameRegex = self.rawValue + "_Predators"
        return getLocalizedString(to: nameRegex)
    }
    
    var lifespan : String? {
        let nameRegex = self.rawValue + "_Lifespan"
        return getLocalizedString(to: nameRegex)
    }
    var weight : String? {
        let nameRegex = self.rawValue + "_Weight"
        return getLocalizedString(to: nameRegex)
    }
    
    var speed : String? {
        let nameRegex = self.rawValue + "_Speed"
        return getLocalizedString(to: nameRegex)
    }
    
    func getLocalizedString(to regex: String) -> String?{
        let locString = NSLocalizedString(regex, tableName: "Mammals", bundle: .main, value: ErrorHandler.localizedStringNotFound, comment: "Mammals")
        if locString == ErrorHandler.localizedStringNotFound {
            return nil
        }
        return locString
    }
    
    var shape : String {
        return self.rawValue
    }
    
    var activity : ActiveTime {
        switch self {
        case .aardvark: return .nocturnal
        case .aardwolf: return .both
        case .africanWildCat: return .both
        case .africanElephant: return .both
        case .africanCivet: return .nocturnal
        case .bandedMongoose: return .diurnal
        case .batEaredFox: return .both
        case .blackBackedJackal: return .both
        case .blackFacedImpala: return .diurnal
        case .blackRhino: return .both
        case .blueWildebeest: return .both
        case .brownHyaena: return .nocturnal
        case .burchellsZebra: return .diurnal
        case .capeFox: return .nocturnal
        case .capeHare: return .nocturnal
        case .capePorcupine: return .nocturnal
        case .caracal: return  .nocturnal
        case .cheetah: return .diurnal
        case .commonDuiker: return .diurnal
        case .commonEland: return .both
        case .commonWarthog: return .diurnal
        case .damaraDikDik: return .both
        case .dwarfMongoose: return .diurnal
        case .gemsbok: return .both
        case .giraffe: return .both
        case .greaterKudu: return .both
        case .groundPangolin: return .nocturnal
        case .hartmannsZebra: return .diurnal
        case .honeyBadger: return .both
        case .klipspringer: return .both
        case .leopard: return .nocturnal
        case .lion: return .both
        case .redHartebeest: return .diurnal
        case .rockDassie: return .diurnal
        case .scrubHare: return .nocturnal
        case .serval: return .both
        case .sideStripedJackal: return .both
        case .slenderMongoose: return .diurnal
        case .smallSpottedCat: return .nocturnal
        case .smallSpottedGenet: return .nocturnal
        case .southAfricanGroundSquirrel: return .diurnal
        case .southAfricanSpringhare: return .nocturnal
        case .southAfricanHedgehog: return .both
        case .southernLesserGalago: return .nocturnal
        case .spottedHyaena: return .both
        case .springbok: return .both
        case .steenbok: return .both
        case .suricate: return .diurnal
        case .treeSquirrel: return .diurnal
        case .whiteRhino: return .both
        case .yellowMongoose: return .diurnal
        }
    }
    
    var mainImage: String {
        switch self {
        case .aardvark: return imageBaseName + "01"
        case .aardwolf: return imageBaseName + "05"
        case .africanWildCat: return imageBaseName + "03"
        case .africanElephant: return imageBaseName + "08" //07
        case .africanCivet: return imageBaseName + "01"
        case .bandedMongoose: return imageBaseName + "05" //04
        case .batEaredFox: return imageBaseName + "04" //01
        case .blackBackedJackal: return imageBaseName + "01"
        case .blackFacedImpala: return imageBaseName + "01"
        case .blackRhino: return imageBaseName + "01" //07
        case .blueWildebeest: return imageBaseName + "011" //01, 010
        case .brownHyaena: return imageBaseName + "01"
        case .burchellsZebra: return imageBaseName + "03"
        case .capeFox: return imageBaseName + "01" //02
        case .capeHare: return imageBaseName + "04" //01
        case .capePorcupine: return imageBaseName + "01"
        case .caracal: return imageBaseName + "04"
        case .cheetah: return imageBaseName + "01"
        case .commonDuiker: return imageBaseName + "01"
        case .commonEland: return imageBaseName + "01"
        case .commonWarthog: return imageBaseName + "02"
        case .damaraDikDik: return imageBaseName + "02"
        case .dwarfMongoose: return imageBaseName + "01"
        case .gemsbok: return imageBaseName + "02" //010 //05
        case .giraffe: return imageBaseName + "09" //04 01
        case .greaterKudu: return imageBaseName + "05" //07
        case .groundPangolin: return imageBaseName + "03" //01
        case .hartmannsZebra: return imageBaseName + "01" //04
        case .honeyBadger: return imageBaseName + "03"
        case .klipspringer: return imageBaseName + "05" //01
        case .leopard: return imageBaseName + "01"  //05 04
        case .lion: return imageBaseName + "05"
        case .redHartebeest: return imageBaseName + "01"
        case .rockDassie: return imageBaseName + "01"
        case .scrubHare: return imageBaseName + "01"
        case .serval: return imageBaseName + "03" //01
        case .sideStripedJackal: return imageBaseName + "01"
        case .slenderMongoose: return imageBaseName + "02"
        case .smallSpottedCat: return imageBaseName + "01"
        case .smallSpottedGenet: return imageBaseName + "02"
        case .southAfricanGroundSquirrel: return imageBaseName + "04"
        case .southAfricanSpringhare: return imageBaseName + "02"
        case .southAfricanHedgehog: return imageBaseName + "01"
        case .southernLesserGalago: return imageBaseName + "02"
        case .spottedHyaena: return imageBaseName + "07" //01
        case .springbok: return imageBaseName + "09" //02
        case .steenbok: return imageBaseName + "03"
        case .suricate: return imageBaseName + "02"
        case .treeSquirrel: return imageBaseName + "04"
        case .whiteRhino: return imageBaseName + "01"
        case .yellowMongoose: return imageBaseName + "02"
        }
    }
    
    var imageBaseName : String {
        return self.rawValue + "/Photos/" + self.rawValue
    }
    
    var faceRect : CGRect? {
        switch self {
        case .aardvark: return CGRect(origin: CGPoint(x: 0.5, y: 0.5), size: CGSize(width: 30, height: 40))
        default:
           return nil
        }
    }
    var faceImage : String {
        switch self {
        case .damaraDikDik: return imageBaseName + "Trans01"
        case .steenbok: return imageBaseName + "Trans02"
        default:
            return imageBaseName + "Trans01"
        }
    }
    
    var facedImage : FacedImage? {
        switch self {
        case .steenbok: return FacedImage(imageName: imageBaseName + "Trans02",
                                          rect: CGRect(origin: CGPoint(x: 0.5, y: 0.5), size: CGSize(width: 30, height: 40)))
        default:
            return FacedImage(imageName: mainImage, rect: nil)
        }
    }
    
    var images: [String] {
        var numbers = [Int]()
        switch self {
        case .aardvark: numbers = [1,2,4]
        case .aardwolf: numbers = [4,5,1]
        case .africanWildCat: numbers = [3,7,2,1,4]
        case .africanElephant: numbers = [12,7,9,10,13]
        case .africanCivet: numbers = [1,2,4]
        case .bandedMongoose: numbers = [5,3,4]
        case .batEaredFox: numbers = [1,2,4]
        case .blackBackedJackal: numbers = [1,3]
        case .blackFacedImpala: numbers = [1,3,4,5,8]
        case .blackRhino: numbers = [8,9,7,1]
        case .blueWildebeest: numbers = [10,7,6,5]
        case .brownHyaena: numbers = [1,2,3,4]
        case .burchellsZebra: numbers = [1,2,3,4]
        case .capeFox: numbers = [1,2,3]
        case .capeHare: numbers = [4,1,2]
        case .capePorcupine: numbers = [1,2,3]
        case .caracal: numbers = [4,7,3]
        case .cheetah: numbers = [1,2,3]
        case .commonDuiker: numbers = [1,2,3]
        case .commonEland: numbers = [1,2,3]
        case .commonWarthog: numbers = [2,3,4,1]
        case .damaraDikDik: numbers = [2,4,5,6] //7
        case .dwarfMongoose: numbers = [4,1,2,3]
        case .gemsbok: numbers = [5,6,9,2]
        case .giraffe: numbers = [4,5,3,2]
        case .greaterKudu: numbers = [3,4,7,1]
        case .groundPangolin: numbers = [1,3]
        case .hartmannsZebra: numbers = [1,2,4,5]
        case .honeyBadger: numbers = [3,2,1]
        case .klipspringer: numbers = [1,3,4]
        case .leopard: numbers = [4,5,6,3,1]
        case .lion: numbers = [12,11,8,5]
        case .redHartebeest: numbers = [4,2,1,3]
        case .rockDassie: numbers = [5,6,7]
        case .scrubHare: numbers = [3,1,2]
        case .serval: numbers = [1,2,3]
        case .sideStripedJackal: numbers = [1,2,3]
        case .slenderMongoose: numbers = [1,4,2,3]
        case .smallSpottedCat: numbers = [1,2]
        case .smallSpottedGenet: numbers = [2,3,4]
        case .southAfricanGroundSquirrel: numbers = [5,6,4,2]
        case .southAfricanSpringhare: numbers = [1,2]
        case .southAfricanHedgehog: numbers = [1,1]
        case .southernLesserGalago: numbers = [1,2]
        case .spottedHyaena: numbers = [8,9,2,6]
        case .springbok: numbers = [9,12,6,2]
        case .steenbok: numbers = [1,3,4]
        case .suricate: numbers = [2,1,3,4]
        case .treeSquirrel: numbers = [1,2,3,4]
        case .whiteRhino: numbers = [11,1,2,3]
        case .yellowMongoose: numbers = [4,6,3,2]
        }
        
        var images = [String]()
        for number in numbers{
            images.append(imageBaseName + "0" + String(number))
        }
        return images
    }
    
    var transparentImages : [(String,Gender)] {
        return [(imageBaseName + "Male",.male),
                (imageBaseName + "Female",.female),
                (imageBaseName + "Trans01",.unknown),
                (imageBaseName + "Trans02",.unknown)]
    }
    
    var face : LabeledImage? {
        for image in self.images{
            let jsonFileName = NSString(string: image).lastPathComponent
            if let jsonData = readLocalJsonFile(forName: jsonFileName),
               let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
               var labeledImage = LabeledImage(json: json),
               let _ = labeledImage.shapes?.filter({$0.label == .Face}).first{
                labeledImage.imageName = image
                return labeledImage
            }
        }
        return nil
    }
    
    var labeledImages : [LabeledImage] {
        var labeldImages = [LabeledImage]()
        for image in images{
            let jsonFileName = NSString(string: image).lastPathComponent
            if let jsonData = readLocalJsonFile(forName: jsonFileName),
               let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
               var labeledImage = LabeledImage(json: json){
                    labeledImage.imageName = image
                    labeldImages.append(labeledImage)
            }
            else{
                labeldImages.append(LabeledImage(imageName: image, shapes: nil, imageSize: nil))

            }
        }
        return labeldImages
    }
    
    var diet : [Diet] {
        switch self {
        case .aardvark: return [.ants,.termites,.insects]
        case .aardwolf: return [.insects,.termites]
        case .africanWildCat: return [.smallMammals,.birds,.frogs,.reptiles,.insects]
        case .africanElephant: return [.leaves,.grass,.seedPods,.roots,.bark,.fruit,.vegetation]
        case .africanCivet: return [.smallMammals,.carrion,.reptiles,.birds,.fish,.fruit,.insects,.frogs]
        case .bandedMongoose: return [.insects,.frogs,.reptiles,.birds,.fruit,.carrion,.eggs]
        case .batEaredFox: return [.reptiles,.insects,.birds,.fruit,.smallMammals]
        case .blackBackedJackal: return [.birds,.insects,.frogs,.berries,.carrion,.smallMammals,.reptiles,.smallAntelope,.fruit]
        case .blackFacedImpala: return [.grass,.leaves,.fruit,.flowers,.seedPods,.bark]
        case .blackRhino: return [.leaves]
        case .blueWildebeest: return [.grass]
        case .brownHyaena: return [.carrion,.insects,.smallMammals,.reptiles,.eggs,.fruit]
        case .burchellsZebra: return [.grass,.leaves]
        case .capeFox: return [.birds,.carrion,.reptiles,.fruit,.insects,.eggs,.smallMammals]
        case .capeHare: return [.leaves,.grass]
        case .capePorcupine: return [.bulbs,.fruit,.roots,.bark,.seeds]
        case .caracal: return [.birds,.smallMammals,.reptiles,.smallAntelope]
        case .cheetah: return [.smallAntelope,.birds]
        case .commonDuiker: return [.leaves,.roots,.seedPods,.bulbs,.flowers,.fruit,.seeds]
        case .commonEland: return [.grass,.leaves]
        case .commonWarthog: return [.grass,.fruit,.roots,.bark,.insects,.seeds,.bulbs]
        case .damaraDikDik: return [.grass,.leaves,.seedPods,.fruit,.flowers]
        case .dwarfMongoose: return [.insects,.reptiles,.birds,.eggs,.smallMammals]
        case .gemsbok: return [.grass,.roots,.bulbs,.seedPods,.fruit]
        case .giraffe: return [.leaves]
        case .greaterKudu: return [.leaves,.grass]
        case .groundPangolin: return [.ants,.termites]
        case .hartmannsZebra: return [.grass,.leaves]
        case .honeyBadger: return [.insects,.birds,.smallMammals,.carrion,.reptiles,.fruit]
        case .klipspringer: return [.leaves,.fruit,.flowers]
        case .leopard: return [.smallAntelope,.carrion,.birds,.fruit,.reptiles,.fish,.smallMammals,.insects]
        case .lion: return [.smallAntelope,.largeAntelope,.giraffe,.smallMammals]
        case .redHartebeest: return [.grass,.leaves]
        case .rockDassie: return [.leaves,.grass,.vegetation,.fruit,.bark]
        case .scrubHare: return [.grass]
        case .serval: return [.smallMammals,.reptiles,.birds,.frogs,.insects]
        case .sideStripedJackal: return [.insects,.carrion,.birds,.smallMammals,.fruit,.vegetation]
        case .slenderMongoose: return [.insects,.birds,.reptiles,.frogs,.smallMammals,.fruit]
        case .smallSpottedCat: return [.smallMammals,.birds,.eggs,.reptiles,.insects]
        case .smallSpottedGenet: return [.insects,.smallMammals,.birds,.frogs,.reptiles,.fruit]
        case .southAfricanGroundSquirrel: return [.grass,.insects,.roots,.berries,.seeds,.bulbs]
        case .southAfricanSpringhare: return [.leaves,.roots,.seeds,.bulbs,.grass]
        case .southAfricanHedgehog: return [.insects,.frogs,.fruit,.reptiles,.eggs,.carrion,.smallMammals]
        case .southernLesserGalago: return [.treeGum,.flowers,.insects]
        case .spottedHyaena: return [.carrion,.smallAntelope,.birds,.insects,.giraffe,.eggs,.smallMammals,.fruit]
        case .springbok: return [.grass,.seedPods,.flowers,.bulbs,.leaves,.roots,.fruit,.seeds]
        case .steenbok: return [.grass,.leaves,.fruit,.berries,.roots,.seedPods,.bulbs]
        case .suricate: return [.insects,.birds,.reptiles,.frogs]
        case .treeSquirrel: return [.flowers,.bark,.fruit,.berries,.insects,.seeds,.leaves]
        case .whiteRhino: return [.grass]
        case .yellowMongoose: return [.insects,.smallMammals,.frogs,.carrion,.termites,.reptiles]
        }
    }
    var habitat : [Habitat] {
        switch self {
        case .aardvark: return [.wideRange]
        case .aardwolf: return [.wideRange]
        case .africanWildCat: return [.wideRange]
        case .africanElephant: return [.wideRange]
        case .africanCivet: return [.forest,.woodland]
        case .bandedMongoose: return [.wideRange,.woodland]
        case .batEaredFox: return [.bushveld,.grassPlains,.rockyArea]
        case .blackBackedJackal: return [.wideRange]
        case .blackFacedImpala: return [.bushveld,.woodland]
        case .blackRhino: return [.bushveld,.grassPlains,.woodland]
        case .blueWildebeest: return [.bushveld,.grassPlains,.woodland]
        case .brownHyaena: return [.woodland,.desert,.rockyArea]
        case .burchellsZebra: return [.bushveld,.grassPlains,.woodland]
        case .capeFox: return [.bushveld,.grassPlains]
        case .capeHare: return [.grassPlains,.semiDesert]
        case .capePorcupine: return [.wideRange]
        case .caracal: return [.bushveld,.rockyArea,.woodland]
        case .cheetah: return [.bushveld,.grassPlains,.woodland]
        case .commonDuiker: return [.woodland,.dryScrub]
        case .commonEland: return [.bushveld,.grassPlains,.woodland]
        case .commonWarthog: return [.bushveld,.grassPlains,.woodland]
        case .damaraDikDik: return [.woodland,.forest]
        case .dwarfMongoose: return [.bushveld,.woodland,.rockyArea]
        case .gemsbok: return [.bushveld,.grassPlains,.desert]
        case .giraffe: return [.bushveld,.woodland]
        case .greaterKudu: return [.woodland]
        case .groundPangolin: return [.wideRange]
        case .hartmannsZebra: return [.mountain]
        case .honeyBadger: return [.wideRange]
        case .klipspringer: return [.mountain]
        case .leopard: return [.wideRange]
        case .lion: return [.wideRange]
        case .redHartebeest: return [.bushveld,.woodland]
        case .rockDassie: return [.mountain]
        case .scrubHare: return [.woodland,.dryScrub]
        case .serval: return [.forest]
        case .sideStripedJackal: return [.woodland]
        case .slenderMongoose: return [.wideRange]
        case .smallSpottedCat: return [.semiDesert,.grassPlains]
        case .smallSpottedGenet: return [.wideRange]
        case .southAfricanGroundSquirrel: return [.bushveld,.semiDesert]
        case .southAfricanSpringhare: return [.bushveld,.grassPlains]
        case .southAfricanHedgehog: return [.wideRange]
        case .southernLesserGalago: return [.bushveld,.forest,.woodland]
        case .spottedHyaena: return [.woodland,.rockyArea]
        case .springbok: return [.bushveld,.grassPlains,.semiDesert]
        case .steenbok: return [.bushveld,.woodland]
        case .suricate: return [.semiDesert,.rockyArea]
        case .treeSquirrel: return [.woodland]
        case .whiteRhino: return [.bushveld,.grassPlains,.woodland]
        case .yellowMongoose: return [.wideRange]
        }
    }
    
}

extension MammalType {
    var differences : [String]? {
        let regex = self.rawValue + "_Differences"
        return getLocalizedString(to: regex)?.components(separatedBy: "&") ?? nil
    }
    var diffCaption : String? {
        let regex = self.rawValue + "_DiffCaption"
        return getLocalizedString(to: regex)
    }
    var diffDescription : String? {
        let regex = self.rawValue + "_DiffDescription"
        return getLocalizedString(to: regex)
    }
    var diffCoordinates : [CGPoint]? {
        switch self{
        case .leopard: return [CGPoint(x: 0.15, y: 0.18),
                               CGPoint(x: 0.5, y: 0.37),
                               CGPoint(x: 0.9, y: 0.88)]
        case .cheetah: return [CGPoint(x: 0.12, y: 0.13),
                               CGPoint(x: 0.5, y: 0.35),
                               CGPoint(x: 0.9, y: 0.82)]
        case .blackRhino: return [CGPoint(x: 0.5, y: 0.13),
                               CGPoint(x: 0.78, y: 0.2),
                               CGPoint(x: 0.9, y: 0.3),
                               CGPoint(x: 0.87, y: 0.5)]
        case .whiteRhino: return [CGPoint(x: 0.4, y: 0.2),
                                  CGPoint(x: 0.9, y: 0.32),
                                  CGPoint(x: 0.9, y: 0.7),
                                  CGPoint(x: 0.88, y: 0.88)]
        case .steenbok: return [CGPoint(x: 0.05, y: 0.11),
                                CGPoint(x: 0.55, y: 0.23),
                               CGPoint(x: 0.65, y: 0.2),
                               CGPoint(x: 0.2, y: 0.12)]
        case .damaraDikDik: return [CGPoint(x: 0.75, y: 0.01),
                               CGPoint(x: 0.80, y: 0.23),
                               CGPoint(x: 0.74, y: 0.23)]
        case .commonDuiker: return [CGPoint(x: 0.1, y: 0.21),
                               CGPoint(x: 0.07, y: 0.3),
                               CGPoint(x: 0.9, y: 0.3)]
        default: return nil
        }
    }
    
}

protocol NamedIcon {
    var name : String { get }
}


extension Mammal {
    var mammalType : MammalType {
        get {
            return MammalType(rawValue: self.mammaltypeValue!)!
        }
        set {
            self.mammaltypeValue = newValue.rawValue
        }
    }
    
    func evaluateMedals() {
        
    }
}

enum Gender{
    case female
    case male
    case unknown
}
