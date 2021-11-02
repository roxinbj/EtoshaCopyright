//
//  SightsViewController.swift
//  Etoscha
//
//  Created by Björn Roxin on 27.05.21.
//

import UIKit
import CoreData
import Firebase

class SightsViewController: UIViewController{
   
    private let categories = MammalCategories.allCases.filter({$0.containedMammals != nil})
    private var mammals : [Mammal]?{
        didSet{
            DispatchQueue.main.async {
                self.collectionView!.reloadData()
            }
        }
    }
    var seenMammalTypes :  [MammalType]? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView!.reloadData()
            }
        }
    }
    var onboarding : [Onboarding]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var collectionView : UICollectionView?
    
    private func fetchMammals(){
            do{
                let request = Mammal.fetchRequest() as NSFetchRequest<Mammal>
                self.mammals = try (context.fetch(request))
            }catch{
                print("Error while fetching animals in sights view")
            }
    }
    
    private func runOnboardingAlert(){
        
        do {
            if let onboarding = try context.fetch(Onboarding.fetchRequest()).first{
                if onboarding.isSightsViewExplained == false {
                    let alert = UIAlertController(title: MyStrings.onboardingHeading.locString, message: MyStrings.onboardingMessage.locString, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: MyStrings.onboardingOk.locString, style: .default, handler: {action in
                        onboarding.isSightsViewExplained = true
                        do { try self.context.save()
                        }catch{}
                    }))
                    alert.addAction(UIAlertAction(title: MyStrings.onboardingRepeat.locString, style: .default, handler: {action in
                        onboarding.isSightsViewExplained = false
                        do { try self.context.save()
                        }catch{}
                    }))
                    present(alert, animated: true, completion: nil)
                }
            }
        }catch{}
    }
    
    private func resetSights(){
        for mammal in mammals! {
            mammal.isSeen = false
        }
        //save data
        do {
            try self.context.save()
        }catch {
            
        }
        
        // fetch data
        self.fetchMammals()
    }
    
    private func swapMammalSightStatus(for mammalType : MammalType){
        if let wantedMammals = mammals?.filter({$0.mammalType == mammalType}){
            assert(wantedMammals.count == 1, "Cannot be more than one mammal")
            wantedMammals.first!.isSeen = !wantedMammals.first!.isSeen
        }
        //save data
        do {
            try self.context.save()
        }catch {
            
        }
        
        // fetch data
        self.fetchMammals()
    }
    
    
    private func fetchSeenMammals(){
        do{
            let request = Mammal.fetchRequest() as NSFetchRequest<Mammal>
            let predicate = NSPredicate(format: "isSeen == true")
            request.predicate = predicate
            self.seenMammalTypes = try (context.fetch(request)).map({$0.mammalType})
        }catch{
            print("Error while fetching animals in sights view")
        }
    }
    
    //MARK: Load View
    override func loadView() {
        super.loadView()
        fetchMammals()
        //runOnboardingAlert()
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultNavBar()
        addSingleTitleToNavBar(title: MyStrings.heading.locString)
        addIconsToNavBarRight(icons: [UIImage(named: "reset")!], targets: [#selector(extensionViewTouched)])
        view.backgroundColor = Appearance.backgroundColor
        let layout = createCompositionalLayout()
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.backgroundColor = Appearance.backgroundColor
        collectionView?.register(TrophyCollectionViewCell.self,forCellWithReuseIdentifier: TrophyCollectionViewCell.reuseIdentifer)
        collectionView?.register(TrophyHeadingView.self, forSupplementaryViewOfKind: "categoryHeaderId", withReuseIdentifier: "headerId")
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.isUserInteractionEnabled = true
        view.addSubview(collectionView ??  UICollectionView())
        setupConstraints()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK: Layout
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            collectionView!.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 10),
            collectionView!.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView!.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            collectionView!.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            switch sectionNumber{
            case 0: return self.firstLayoutSection()
            default: return self.firstLayoutSection()
            }
        }
    }
    
    private func firstLayoutSection() -> NSCollectionLayoutSection {
    
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension:
       .absolute(130))

          let item = NSCollectionLayoutItem(layoutSize: itemSize)
       item.contentInsets.bottom = 5
        item.contentInsets.leading = 5

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
       heightDimension: .estimated(200))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
      section.contentInsets.leading = 5
        section.contentInsets.bottom = 5
        
        //section.orthogonalScrollingBehavior = .continuous

        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension:
            .fractionalWidth(1), heightDimension: .estimated(44)), elementKind: "categoryHeaderId", alignment:
            .topLeading)
            ]
      return section
    }
    

}

extension SightsViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    //MARK: Collection View Datasource and Delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories[section].underlyingMammalTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrophyCollectionViewCell.reuseIdentifer, for: indexPath) as! TrophyCollectionViewCell
        let mammalType = categories[indexPath.section].underlyingMammalTypes[indexPath.row]
        
        let mammal = mammals?.filter({$0.mammalType == mammalType})
        assert(mammal?.count == 1, "Should only find one mammal")
                
        cell.sightViewDelegate = self
        
        if let faceShape = mammalType.face?.shapes?.filter({$0.label == .Face}).first{
            let image = UIImage(named: mammalType.face!.imageName)?.crop(with: faceShape.rect)
            cell.configure(withImage: image!, title: mammalType.shortName, index: indexPath)
            
        }else {
            cell.configure(withImageName: mammalType.mainImage, title: mammalType.shortName, index: indexPath)
        }

        if mammal!.first!.isSeen{
            cell.set(toOpague: false)
        }else {
            cell.set(toOpague: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! TrophyHeadingView
        let text = categories[indexPath.section].shortName
        header.configure(with: text)
        return header
    }
}

extension SightsViewController : SightDelegate{
    func singleTap(at index: IndexPath) {
        let mammalType = categories[index.section].underlyingMammalTypes[index.row]
        Analytics.logEvent(MyAnalyticsEvents.markAsSeenMammal.rawValue, parameters: [MyAnalyticsParameters.mammalType.rawValue : mammalType.rawValue,
                                                                                     MyAnalyticsParameters.markedAsSeenOrigin.rawValue: MarkAsSeenOrigin.FromSights.rawValue])
        swapMammalSightStatus(for: categories[index.section].underlyingMammalTypes[index.row])
        AppStoreReviewManager.requestReviewIfAppropiate()
    }
    
    func doubleTap(at index: IndexPath) {
        let mammalType = categories[index.section].underlyingMammalTypes[index.row]
        let vc  = MammalController()
        vc.mammalType = mammalType
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SightsViewController {
    //MARK: Navigation and Actions
    
    @objc func extensionViewTouched(){
        showAlert()        
    }
    
    func showAlert(){
        let alert = UIAlertController(title: MyStrings.resetHeading.locString, message: MyStrings.resetMessage.locString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: MyStrings.resetCancel.locString, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: MyStrings.resetConfirm.locString, style: .destructive, handler: {action in
            self.resetButtonTouched()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMammal"{
            if let destination = segue.destination as? MammalController, let mammalType = sender as? MammalType{
                destination.mammalType = mammalType
            }
        }
    }
}


extension SightsViewController: MammalToSights{
    func changeInMammalSeenStatus() {
        fetchMammals()
        DispatchQueue.main.async {
            self.collectionView!.reloadData()
        }
    }
}

extension SightsViewController {
    func resetButtonTouched() {
        resetSights()
        DispatchQueue.main.async {
            self.collectionView!.reloadData()
        }
    }
}

extension SightsViewController {
    enum MyStrings : String {
        case heading = "_heading"
        case button = "_button"
        case resetHeading = "_resetHeading"
        case resetMessage = "_resetMessage"
        case resetCancel = "_resetCancel"
        case resetConfirm = "_resetConfirm"
        case onboardingHeading = "_onboardingTitle"
        case onboardingMessage = "_onboardingMessage"
        case onboardingOk = "_onboardingOk"
        case onboardingRepeat = "_onboardingRepeat"

    
        var locString : String {
            getLocalizedString(for: self.rawValue, viewType: EtoshaViews.sightingsView)
        }
    }
}
