//
//  MammalCollectionViewController.swift
//  Etoscha
//
//  Created by Björn Roxin on 27.05.21.
//

import UIKit
import FirebaseAnalytics

class MammalCollectionViewController: UICardsViewController {
    
    @IBOutlet weak var mammalsNavItem: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        if mammalsNavItem != nil {
            mammalsNavItem.title = NSLocalizedString("TabItem_animals", tableName: "Texts", bundle: .main, value: "Mammals", comment: "Mammals")
        }
        
        if isCardsEmpty(){
            self.heading = NSLocalizedString("MammalsView_heading", tableName: "Texts", bundle: .main, value: ErrorHandler.localizedStringNotFound, comment: "Mammals")
                
            setCards(bigCards: [    MammalCategories.Cats,
                                    MammalCategories.Giants,
                                    MammalCategories.HoofedLarge ],
                     smallCards: [  MammalCategories.HoofedSmall,
                                    MammalCategories.Hyaenas,
                                    MammalCategories.Canines,
                                    MammalCategories.SmallMammals])
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, didSelectItemAt: indexPath)
        
        let card = getCard(for: indexPath)
        
        // Go to Mammal
        if let animal = card as? MammalType {
            Analytics.logEvent(MyAnalyticsEvents.viewedMammal.rawValue, parameters: [MyAnalyticsParameters.mammalType.rawValue: animal.rawValue])
            let vc = MammalController()
        
            vc.mammalType = animal
            navigationController?.pushViewController(vc, animated: true)
        }
        
        //Go to next Category
        if let category = card as? MammalCategories{
            Analytics.logEvent(MyAnalyticsEvents.viewedMammalCategory.rawValue, parameters: [MyAnalyticsParameters.mammalCategoryType.rawValue: category.rawValue])
            let vc = MammalCollectionViewController()
            var bigCards = [CardAble]()
            var smallCards : [CardAble]?
            var allCards = [CardAble]()
            if category.containedMammals != nil {
                allCards = category.containedMammals!
            } else if category.subcategory != nil {
                allCards = category.subcategory!
            }

            let numberOfBigCards = getNumberOfBigCards(for: allCards.count)
            if numberOfBigCards >= allCards.count {
                bigCards = allCards
                smallCards = nil
            }else {
                let end = allCards.count - 1
                bigCards = Array(allCards[0...(numberOfBigCards - 1)])
                smallCards = Array(allCards[numberOfBigCards...end])
            }
            
            // Add Card if Spot the difference exists to bigcards
            if category.spotTheDiffernce != nil {
                bigCards.append(category.spotTheDiffernce!)
            }
            
            vc.setCards(bigCards: bigCards, smallCards: smallCards)
            vc.heading = category.shortName
            navigationController?.pushViewController(vc, animated: true)
        }
        
        // Go to Difference View
        if let myCard = card as? MammalDifference{
            let vc = MammalComparisonViewController()
            vc.diffType = myCard
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let animal = sender as? MammalType, let vc = segue.destination as? MammalController{
            vc.mammalType = animal
        }
        
        if let category = sender as? MammalCategories, let vc = segue.destination as? MammalCollectionViewController  {
            var newCards = [CardAble]()
            if category.containedMammals != nil {
                newCards = category.containedMammals!
            } else if category.subcategory != nil {
                newCards = category.subcategory!
            }

            let numberOfBigCards = getNumberOfBigCards(for: newCards.count)
            if numberOfBigCards >= newCards.count {
                vc.setCards(bigCards: newCards, smallCards: nil)
            }else {
                let end = newCards.count - 1
                let big = Array(newCards[0...(numberOfBigCards - 1)])
                let small = Array(newCards[numberOfBigCards...end])
                vc.setCards(bigCards: big, smallCards: small)
            }
        }
    }
    
    private func getNumberOfBigCards(for numberOfCards: Int) -> Int {
        switch numberOfCards{
        case 0,1,2,3,4: return numberOfCards
        default:
            if(numberOfCards % 2 == 0) {
                return 4
            }else{
                return 3
            }
        }
    }
}
