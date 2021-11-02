//
//  JsonHandler.swift
//  Etoscha
//
//  Created by Björn Roxin on 30.07.21.
//

import Foundation

func readLocalJsonFile(forName name: String) -> Data? {
    do {
        if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"), let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
            return jsonData
        }
        
    }catch {
        print(error)
    }
    return nil
}
