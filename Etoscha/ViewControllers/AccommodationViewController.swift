//
//  AccommodationViewController.swift
//  Etoscha
//
//  Created by Björn Roxin on 26.05.21.
//

import UIKit
import FirebaseAnalytics

class AccommodationViewController: UICardsViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultNavBar()
        addSingleTitleToNavBar(title: MyStrings.title.locString)
        if isCardsEmpty() {
            setCards(bigCards: [Accommodations.Okaukuejo,
                                Accommodations.Namutoni,
                                Accommodations.Halali,
                                Accommodations.Olifantsrus,
                                Accommodations.Dolomite,
                                Accommodations.Onkoshi], smallCards: nil)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, didSelectItemAt: indexPath)
        if let camp = getCard(for: indexPath) as? Accommodations{
            let vc = CampController()
            vc.campName = camp
            navigationController?.pushViewController(vc, animated:  true)
            //performSegue(withIdentifier: ViewNames.camp.seque, sender: camp)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ViewNames.camp.seque {
            guard let dest = sender  as? Accommodations else {return }
            if let vc = segue.destination as? CampController {
                vc.campName = dest
            }
        }
    }
}

extension AccommodationViewController {
    enum MyStrings:String {
        case title = "_heading"
        
        var locString : String {
            getLocalizedString(for: self.rawValue, viewType: EtoshaViews.accommodationsView)
        }
    }
}
