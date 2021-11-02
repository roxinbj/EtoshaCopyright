//
//  SingleTitleController.swift
//  Etoscha
//
//  Created by Björn Roxin on 12.05.21.
//

import UIKit

extension UIViewController {
    
    func setupDefaultNavBar(){
        self.navigationController?.navigationBar.barTintColor = Appearance.backgroundColor
        self.navigationController?.navigationBar.tintColor =  Appearance.primaryColor
    }
    
    func addSingleTitleToNavBar(title: String){
        // Create the label
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        let paragraphstyle = NSMutableParagraphStyle()
        paragraphstyle.alignment = .center
        
        let attributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: Appearance.black,
            .font: UIFontMetrics(forTextStyle: .title1).scaledFont(for: UIFont(name: Appearance.semiBold, size: 18)!),
            .paragraphStyle: paragraphstyle
            ]
        
        let attributedString = NSAttributedString(string: title, attributes: attributes)
        label.attributedText = attributedString
        label.numberOfLines = 0
        //label.sizeToFit()
        label.textAlignment = NSTextAlignment.center
        
        self.navigationItem.titleView = label
    }
    
    func addDoubleTitleToNavBar(title: String, subtitle: String){
        
        // Create the label
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        let titleParagraphstyle = NSMutableParagraphStyle()
        titleParagraphstyle.alignment = .left
        
        let titleFontAttributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: Appearance.black,
            .font: UIFontMetrics(forTextStyle: .title1).scaledFont(for: UIFont(name: Appearance.semiBold, size: 18)!),
            .paragraphStyle: titleParagraphstyle
            ]
        
        let titleAttributedString = NSAttributedString(string: title, attributes: titleFontAttributes)
        label.attributedText = titleAttributedString
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = NSTextAlignment.left

        // Create subtitle label
        let secondLabel = UILabel()
        secondLabel.adjustsFontForContentSizeCategory = true
        let subTitleParagraphstyle = NSMutableParagraphStyle()
        subTitleParagraphstyle.alignment = .left
        let subTitleFontAttributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: Appearance.gray,
            .font: UIFontMetrics(forTextStyle: .title2).scaledFont(for: UIFont(name: Appearance.light, size: 14)!),
            .paragraphStyle: subTitleParagraphstyle
            ]
        
        let subTitleAttributedString = NSAttributedString(string: subtitle, attributes: subTitleFontAttributes)
        secondLabel.attributedText = subTitleAttributedString
        secondLabel.numberOfLines = 0
        secondLabel.sizeToFit()
        secondLabel.textAlignment = NSTextAlignment.left
      
        let textStack = UIStackView(arrangedSubviews: [label, secondLabel])
        textStack.axis = .horizontal
        textStack.spacing = 20
        textStack.distribution = .fillProportionally
        
        self.navigationItem.titleView = textStack
    }
    
    func addIconsToNavBarRight(icons : [UIImage], selectedIcons: [UIImage]? = nil, targets : [Selector?]? = nil) {
        if selectedIcons != nil {
            assert(icons.count == selectedIcons!.count)
        }
        
        var buttons = [UIButton]()
        for index in icons.indices{
            let normalImage = icons[index] //UIImage(named: icons[index])?.withRenderingMode(.automatic).withTintColor(Appearance.orangeBright)
            let highlightedImage = selectedIcons?[index] ??  icons[index] //UIImage(named: icons[index])?.withRenderingMode(.automatic).withTintColor(Appearance.orangeDark)
            let btn = UIButton.init(type: .custom)
            btn.setImage(normalImage, for: .normal)
            btn.contentMode = .scaleAspectFit
            btn.setImage(highlightedImage, for: .selected)
            if let selector = targets?[index]{
                btn.addTarget(self, action: selector, for: .touchUpInside)
                btn.addTarget(self, action: selector, for: .touchUpInside)
            }
            buttons.append(btn)
        }
       
        let stackview = UIStackView.init(arrangedSubviews: buttons)
        stackview.distribution = .equalSpacing
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.spacing = 8
        
        let rightBarButton = UIBarButtonItem(customView: stackview)
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
}
