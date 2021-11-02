//
//  Socialability.swift
//  Etoscha
//
//  Created by Björn Roxin on 19.07.21.
//

import Foundation

enum Sociability: String , NamedIcon{
    case solitary = "Solitary"
    case pairs = "Pairs"
    case smallFamilyGroups = "Small Family Groups"
    
    var name : String {
        return NSLocalizedString(self.rawValue, tableName: "Icons", bundle: .main, value: self.rawValue, comment: "Sociability")
    }
}
