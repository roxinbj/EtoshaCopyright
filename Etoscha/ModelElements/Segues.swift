//
//  Segues.swift
//  Etoscha
//
//  Created by Björn Roxin on 21.04.21.
//

import Foundation

enum SegueTypes : String {
    case toCardView  = "toCardView"
    case toMammalView = "toMammalView"
    case toAccommodationView = "toAccommodationView"
    case toGateTimesView = "toGateTimesView"
    case toContactNumbersView = "toContactNumbersView"
    case toAboutUs = "toAboutUsView"
    case toAboutEtosha = "toAboutEtoshaView"
    case toInfo = "toInfoView"
    case toMap = "toMapView"
}

enum ViewNames : String {
    case info = "Info"
    case contactNumbers = "Need Help"
    case gateTimes = "Gate Times"
    case accommodation = "Need a bed?"
    case aboutUs = "About Us"
    case aboutEtosha = "About Etosha"
    case camp = "Camp"
    case mammalsCategory = "Category"
    case mammalList = "MammalList"
    case mammalDetail = "Mammal Details"
    case map = "Etosha Map"
    case welcome = "Welcome View"
    case sights = "My Sighting Trophies"
    
    var seque: String {
        switch self{
        case .info:
            return "toInfoView"
        case .contactNumbers:
            return "toContactNumbersView"
        case .gateTimes:
            return "toGateTimesView"
        case .accommodation:
            return "toAccommodationView"
        case .aboutUs:
            return "toAboutUsView"
        case .aboutEtosha:
            return "toAboutEtoshaView"
        case .camp:
            return "toCampController"
        case .mammalsCategory:
            return "toMammalCategory"
        case .mammalList:
            return "toMammalList"
        case .mammalDetail: return "toMammalDetail"
        case .map: return "toMap"
        case .welcome: return "toWelcomeView"
        case .sights: return "toSights"
        }
    }
    
}
