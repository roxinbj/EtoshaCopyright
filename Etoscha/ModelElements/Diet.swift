//
//  Diet.swift
//  Etoscha
//
//  Created by Björn Roxin on 19.07.21.
//

import Foundation

enum Diet : String, NamedIcon {
    case seeds = "Seeds"
    case berries = "Berries"
    case fruit = "Fruit"
    case flowers = "Flowers"
    case leaves = "Leaves"
    case vegetation = "Vegetation"
    case roots = "Roots"
    case bulbs = "Bulbs"
    case bark = "Bark"
    case seedPods = "Seed Pods"
    case treeGum = "Tree Gum"
    case grass = "Grass"
    case insects = "Insects"
    case ants  = "Ant"
    case termites = "Termites"
    case reptiles = "Reptiles"
    case eggs = "Eggs"
    case fish = "Fish"
    case frogs = "Frogs"
    case crabs = "Crabs"
    case birds = "Birds"
    case smallMammals = "SmallMammals"
    case smallAntelope = "SmallAntelope"
    case largeAntelope = "LargeAntelope"
    case giraffe = "Giraffe"
    case carrion = "Carrion"
    
    var image : String{
        switch self {
        case .seeds: return "Seeds"
        case .berries: return "Berries"
        case .fruit: return "Fruit"
        case .flowers: return "Flowers"
        case .leaves: return "Leaves"
        case .vegetation: return "Vegetation"
        case .roots: return "Roots"
        case .bulbs: return "Bulbs"
        case .bark: return "Bark"
        case .seedPods: return "SeedPods"
        case .treeGum: return "TreeGum"
        case .grass: return "Grass"
        case .insects: return "Insects"
        case .ants: return "Ant_alt"
        case .termites: return "Termites"
        case .reptiles: return "Reptiles"
        case .eggs: return "Eggs"
        case .fish: return "Fish"
        case .frogs: return "Frogs"
        case .crabs: return "Crabs"
        case .birds: return "Birds"
        case .smallMammals: return "SmallMammals"
        case .smallAntelope: return "SmallAntelope"
        case .largeAntelope: return "LargeAntelope"
        case .giraffe: return "GiraffeIcon"
        case .carrion: return "Carion"
        }
    }
    
    var name : String {
        return NSLocalizedString(self.rawValue, tableName: "Icons", bundle: .main, value: self.rawValue, comment: "Diet")
    }
}
