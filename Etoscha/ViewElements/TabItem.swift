//
//  TabItem.swift
//  Etoscha
//
//  Created by Björn Roxin on 21.04.21.
//

import UIKit

enum TabItem : String, CaseIterable {
    case home = "home"
    case animals = "animals"
    case info = "more"
    
    var icon : UIImage {
        switch self {
        case .home:
            return UIImage(named: "home")!
        case .animals:
            return UIImage(named: "paw-solid")!
        case .info:
            return UIImage(named: "info")!
        }
    }
    
    var title: String {
        let regex = "TabItem_" + self.rawValue
        return getLocalizedString(to: regex) ?? "No Item found"
    }
    
    func getLocalizedString(to regex: String) -> String?{
        let locString = NSLocalizedString(regex, tableName: "Texts", bundle: .main, value: ErrorHandler.localizedStringNotFound, comment: "Texts")
        if locString == ErrorHandler.localizedStringNotFound {
            return nil
        }
        return locString
    }
    
}
