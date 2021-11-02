//
//  Analytics.swift
//  Etoscha
//
//  Created by Björn Roxin on 20.07.21.
//

import Foundation


enum MyAnalyticsEvents : String {
    // MammalType
    case viewedMammal
    case viewedMammalDetail
    case markAsSeenMammal
    case viewedMammalCategory
    case viewedInfo
    case clickedAnWelcomeItem
    
    //DetailInfo
    case selected_mammalDetailedView
    
    //Buttons
    case pressedCard
    case pressedGateButton
    case modifiedFieldNote
    case sliderMoved
}

enum MyAnalyticsParameters : String {
    // MammalType
    case mammalType
    case infoType
    case cardType
    case mammalCategoryType
    case editMode
    case markedAsSeenOrigin
    case welcomeItems
}

enum MarkAsSeenOrigin:String{
    case Tickbox
    case DoubleClick
    case FromSights
}

enum CardType:String {
    case small
    case big
    case welcome
}

enum EditMode : String {
    case add
    case edit
    case remove
}
