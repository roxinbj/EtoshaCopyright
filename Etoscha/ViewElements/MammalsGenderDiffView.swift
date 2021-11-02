//
//  MammalsGenderDiffView.swift
//  Etoscha
//
//  Created by Björn Roxin on 31.05.21.
//

import UIKit

class MammalGenderDiffView: UIView {

    private var etoshaPopulation : UILabel?
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
