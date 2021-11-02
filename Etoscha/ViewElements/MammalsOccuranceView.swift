//
//  MammalsOccuranceView.swift
//  Etoscha
//
//  Created by Björn Roxin on 31.05.21.
//

import UIKit

class MammalOccuranceView: UIView {

    private var etoshaPopulation : UILabel?
    private var boxView : UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray
    
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupBox(){
        boxView = UIView()
        
    }
    
    
    
    
    
}



