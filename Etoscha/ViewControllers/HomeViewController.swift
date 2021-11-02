//
//  HomeViewController.swift
//  Etoscha
//
//  Created by Björn Roxin on 18.03.21.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    // Views
    private var collectionView: UICollectionView?
    let loadingVC = loadingViewController()

    // Data
    private var cards : [HomeCards] = HomeCards.allCases
    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    //MARK: Load View
    override func loadView() {
        super.loadView()
        showSpinner()
        // Reset App
//        print("Reset App")
//        do{
//            let stats = try context.fetch(Onboarding.fetchRequest()) as [Onboarding]
//            for stat in stats{
//                context.delete(stat)
//            }
//
//            try self.context.save()
//        }catch {
//            print("Reset of App failed")
//        }
        
        
        // Initialize Core Data
        do{
            let onboardingValues = try context.fetch(Onboarding.fetchRequest()) as [Onboarding]
            
            if onboardingValues.isEmpty {
                let stat = Onboarding(context: context)
                setupCoreData()
                stat.isCoreDataSet = true
                stat.isTimeDiffDemoDone = false
                
                try self.context.save()
            }
            
        }catch {
            print("Init of core Data failed")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Appearance.backgroundColor
        let layout = createCompositionalLayout()
        collectionView = UICollectionView(frame: self.view.safeAreaLayoutGuide.layoutFrame, collectionViewLayout: layout)
        collectionView?.backgroundColor = Appearance.backgroundColor
        collectionView?.register(HomeCollectionViewCell.self,forCellWithReuseIdentifier: HomeCollectionViewCell.reuseIdentifer)
        collectionView?.register(CardCollectionItem.self, forCellWithReuseIdentifier: CardCollectionItem.reuseIdentifer)
//        DispatchQueue.main.async {
//            self.collectionView?.reloadData()
//        }
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.isUserInteractionEnabled = true
        view.addSubview(collectionView ??  UICollectionView())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        removeSpinner()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        navigationController?.setNavigationBarHidden(true, animated: false)
        //AppUtility.lockOrientation(.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    
    
}

extension HomeViewController: UICollectionViewDataSource{
    //MARK: CollectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        switch section {
        case 0: return 1
        case 1: return cards.count
        default:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.reuseIdentifer, for: indexPath) as! HomeCollectionViewCell
            cell.configure(withImageName: "welcome", title: MyStrings.welcomeHeading.locString ,subtitle: MyStrings.welcomeSubHeading.locString)
            return cell
        }
        else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionItem.reuseIdentifer, for: indexPath) as! CardCollectionItem
            let card = cards[indexPath.row]
            cell.configure(withImageName: card.mainImage, title: card.shortName ,asSmallCard: false)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            Analytics.logEvent(MyAnalyticsEvents.pressedCard.rawValue, parameters: [MyAnalyticsParameters.cardType.rawValue: CardType.welcome.rawValue])
            let vc = WelcomeViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        
        if indexPath.section == 1 {
            Analytics.logEvent(MyAnalyticsEvents.pressedCard.rawValue, parameters: [MyAnalyticsParameters.cardType.rawValue: CardType.big.rawValue])
            let cell = cards[indexPath.row]
            switch cell {
            case .Mammals:
                let vc = MammalCollectionViewController()
                navigationController?.pushViewController(vc, animated: true)
                //self.tabBarController?.selectedIndex = 1
            case .Maps:
                let vc = MapViewController()
                vc.focusCamp = .Okaukuejo
                navigationController?.pushViewController(vc, animated: true)
            case .Sights:
                let vc = SightsViewController()
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    //MARK: Layout
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            switch sectionNumber {
            case 0: return self.firstLayoutSection()
            case 1: return self.secondLayoutSection()
            default: return self.firstLayoutSection()
            }
        }
    }
    
    private func firstLayoutSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 5
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.38))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 5, leading: 5, bottom: 0, trailing: 5)
       
        let section = NSCollectionLayoutSection(group: group)
        
        //section.orthogonalScrollingBehavior = .continuous// groupPaging
        
        return section
    }
    
    private func secondLayoutSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 5
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
       
        let section = NSCollectionLayoutSection(group: group)
        
        //section.orthogonalScrollingBehavior = .continuous// groupPaging
        
        return section
    }
}

extension HomeViewController {
    //MARK: Core Data
    private func setupCoreData(){
        clearMammalAndMedalCoreData()
        creatMammalDataBase()
        
        do {
            let mammals = try context.fetch(Mammal.fetchRequest()) as [Mammal]
            print("Mammals in Core Data: \(mammals.count)")
            
        }catch {
            
        }
        
    }
    
    private func clearMammalAndMedalCoreData() {
        do {
            let mammals = try context.fetch(Mammal.fetchRequest())
            for object in mammals{
                self.context.delete(object)
            }
        }catch {
            
        }
        
        do {
            try self.context.save()
        }catch {
            
        }
    }
    
    private func creatMammalDataBase() {
        for mammalType in MammalType.allCases{
            // create Mammal
            let mammal = Mammal(context: context)
            mammal.isSeen = false
            mammal.mammalType = mammalType
            
            // save Data
            do{
                try self.context.save()
            }catch {
                print("could not save context")
            }
        }
    }
}

extension HomeViewController : UICollectionViewDelegate {
    
}

extension HomeViewController{
    enum MyStrings :String {
        case welcomeHeading = "_welcomeHeading";
        case welcomeSubHeading = "_welcomeSubHeading";
        var locString : String {
            getLocalizedString(for: self.rawValue, viewType: EtoshaViews.homeView)
        }
    }
}

enum HomeCards : String, CaseIterable, CardAble {
    case Mammals = "mammals"
    case Sights = "sights"
    case Maps = "map"
    
    var mainImage : String {
        switch self {
        case .Mammals: return MammalType.lion.mainImage
        case .Sights: return "SpottingTourist"
        case .Maps: return "EtoshaMapColor"
        }
    }
    
    var shortName : String {
        let nameRegex = EtoshaViews.homeView.rawValue + "_" + self.rawValue
        return getLocalizedString(to: nameRegex) ?? "Not found shortName"
    }
    
    func getLocalizedString(to regex: String) -> String?{
        let locString = NSLocalizedString(regex, tableName: "Texts", bundle: .main, value: ErrorHandler.localizedStringNotFound, comment: "Texts")
        if locString == ErrorHandler.localizedStringNotFound {
            return nil
        }
        return locString
    }
    
}


extension UIImage {
    func outline(width: CGFloat, color: UIColor) -> UIImage? {
            UIGraphicsBeginImageContext(size)
            let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            self.draw(in: rect, blendMode: .normal, alpha: 1.0)
            let context = UIGraphicsGetCurrentContext()
            context?.setStrokeColor(color.cgColor)
            context?.setLineWidth(width)
            context?.stroke(rect)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return newImage

        }
}
