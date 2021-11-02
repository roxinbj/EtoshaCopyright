//
//  InfoController.swift
//  Etoscha
//
//  Created by Björn Roxin on 12.05.21.
//

import UIKit
import FirebaseAnalytics

class InfoController: UICardsViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultNavBar()
        addSingleTitleToNavBar(title: MyStrings.title.locString)
        if isCardsEmpty(){
            setCards(bigCards: [
                        InfoCardType.gateTimes,
                        InfoCardType.fieldNotes,
                        InfoCardType.accommodation],
                     smallCards: [
                        InfoCardType.gameDriveInformation,
                        InfoCardType.contactNumbers,
                        InfoCardType.aboutEtosha,
                        InfoCardType.aboutUs])
        }
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, didSelectItemAt: indexPath)
        let card = getCard(for: indexPath)
        if let infoCard = card as? InfoCardType {
            //TODO: Change Seque mechanism
            Analytics.logEvent(MyAnalyticsEvents.viewedInfo.rawValue, parameters: ["InfoType": infoCard.rawValue])
            var vc : UIViewController
            switch infoCard {
            case .aboutEtosha:
                vc = AboutEtoshaViewController()
            case .aboutUs:
                vc = AboutUsViewController()
            case .accommodation:
                vc = AccommodationViewController()
            case .fieldNotes:
                vc = FieldNotesTableViewController()
            case .gameDriveInformation:
                vc = HintsViewController()
            case .gateTimes:
                vc = GateTimesViewController()
            case .contactNumbers:
                vc = ContactNumbersViewController()
            }
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
extension InfoController{
    //MARK: MyStrings
    enum MyStrings : String {
        case title = "_title"

        var locString : String {
            getLocalizedString(for: self.rawValue, viewType: EtoshaViews.infoView)
        }
    }
}

extension InfoController{
    //MARK: InfoCardType
    enum InfoCardType : String, CaseIterable, CardAble{
        case fieldNotes
        case gameDriveInformation
        case contactNumbers
        case gateTimes
        case accommodation
        case aboutEtosha
        case aboutUs
        
        var shortName : String {
            switch self {
            case .fieldNotes: return getLocalizedString(for: "_fieldNotesTitle", viewType: EtoshaViews.infoView)
            case .gameDriveInformation: return getLocalizedString(for: "_hintsTitle", viewType: EtoshaViews.infoView)
            case .contactNumbers: return getLocalizedString(for: "_callHelpTitle", viewType: EtoshaViews.infoView)
            case .gateTimes: return getLocalizedString(for: "_gateTimesTitle", viewType: EtoshaViews.infoView)
            case .accommodation: return getLocalizedString(for: "_accommodationTitle", viewType: EtoshaViews.infoView)
            case .aboutUs: return getLocalizedString(for: "_aboutUsTitle", viewType: EtoshaViews.infoView)
            case .aboutEtosha: return getLocalizedString(for: "_aboutEtoshaTitle", viewType: EtoshaViews.infoView)
            }
        }
        
        var mainImage: String {
            switch self {
            case .fieldNotes: return "FieldNotes"
            case .aboutEtosha: return "AboutEtosha"
            case .aboutUs: return "NamibianFlagPaw"
            case .accommodation: return "Olifantsrus03"
            case .gateTimes: return "GateTimes"
            case .contactNumbers: return "GotStuck"
            case .gameDriveInformation: return "GameDriveTips"
            }
        }
        
        var seque : String {
            switch self {
            case .fieldNotes: return "toFieldNotesView"
            case .aboutEtosha: return "toAboutEtoshaView"
            case .aboutUs: return "toAboutUsView"
            case .accommodation: return "toAccommodationView"
            case .gateTimes: return "toGateTimesView"
            case .contactNumbers: return "toContactNumbersView"
            case .gameDriveInformation: return "toGameDriveInformationView"
            }
        }
    }        
}

