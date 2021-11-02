//
//  MainTabBarController.swift
//  Etoscha
//
//  Created by Björn Roxin on 21.04.21.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabItems()
        self.tabBar.backgroundColor = Appearance.primaryColor
        // Do any additional setup after loading the view.
    }
    
    func setupTabItems() {
        self.tabBar.barTintColor = Appearance.primaryColor
        self.tabBar.tintColor = UIColor.white
        self.tabBar.unselectedItemTintColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.5)//Appearance.lightGray

        for index in self.tabBar.items!.indices
        {
            let item  = self.tabBar.items![index]
            let custumTabItem = TabItem.allCases[index]
            item.image = custumTabItem.icon
            item.title = custumTabItem.title
            
            let fontName = UIFont(name: Appearance.bold, size: 12)
            let paragraphstyle = NSMutableParagraphStyle()
            paragraphstyle.alignment = .center
            
            let attributes : [NSAttributedString.Key: Any] = [
                .font: UIFontMetrics(forTextStyle: .caption1).scaledFont(for: fontName!),
                .paragraphStyle: paragraphstyle
                ]
            item.setTitleTextAttributes(attributes, for: .normal)
        }
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        for vc in viewControllers!{
            if let newVc = vc as? UINavigationController{
                newVc.popToRootViewController(animated: false)
            }
        }
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cat = sender as? MammalCategories, segue.identifier == "toMammalCategory"{
            let vc = segue.destination as! MammalCollectionViewController
            vc.performSegue(withIdentifier: "toMammalCategory", sender: cat)
        }
    }
    

}
