//
//  TrophyHeadingView.swift
//  Etoscha
//
//  Created by Björn Roxin on 02.06.21.
//

import UIKit

class TrophyHeadingView: UICollectionReusableView {
    let label = UILabel()
    func configure(with title: String){
        label.text = title
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Section Title"
        
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
