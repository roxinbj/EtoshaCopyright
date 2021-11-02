//
//  ActiveTime.swift
//  Etoscha
//
//  Created by Björn Roxin on 19.07.21.
//

import Foundation

enum ActiveTime : String, NamedIcon{
    case diurnal = "Diurnal"
    case nocturnal = "Nocturnal"
    case both = "Day and Night"
    
    var image : String{
        return "clock-solid"
    }
    var name : String {
        return NSLocalizedString(self.rawValue, tableName: "Icons", bundle: .main, value: self.rawValue, comment: "ActiveTime")
    }
    
}
