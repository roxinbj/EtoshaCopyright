//
//  DetailViewMammalsController.swift
//  Etoscha
//
//  Created by Björn Roxin on 29.05.21.
//

import UIKit
import FirebaseAnalytics

class DetailViewMammalsController: UIViewController {
    //MARK: Constants
    private let spacing : CGFloat = 20
    private let padding : CGFloat = 20
    private let backButtonWidth : CGFloat = 50
    private let tableHeight : CGFloat = 130
    private let leftHeadingWidthRatio : CGFloat = 0.28
    private let leftHeadingHeightRatio : CGFloat = 0.2
    private let rightHeadingWidthRatio : CGFloat = 0.35
    private let rightHeadingHeightRatio : CGFloat = 0.2
    private let itemSpacing : CGFloat = 5
    private let itemPadding : CGFloat = 5
    private let itemHeight: CGFloat = 65
    private let sectionLeading : CGFloat = 15
    
    //MARK: Views
    private var collectionView : UICollectionView?
    private var backButton = UIButton()
    private var headingViewLeft = UILabel()
    private var headingViewRight = UILabel()
    private var horizontalLine = UIView()
    private let scrollView = UIScrollView()
    
    private let dietVC = MammalDietViewController()
    private let habitatVC = MammalHabitatViewController()
    private let sizeVC = MammalSizeViewController()
    private let appearanceVC = MammalAppearanceViewController()
    private let factsVC = MammalFactsViewController()
    private let behaviorVC = MammalBehaviorViewController()
    
    //MARK: Data
    var mammalType : MammalType? {
        didSet{
            dietVC.mammalType = mammalType
            behaviorVC.mammalType = mammalType
            sizeVC.mammalType = mammalType
            habitatVC.mammalType = mammalType
            appearanceVC.mammalType = mammalType
            factsVC.mammalType = mammalType
        }
    }
    
    private var buttonIcons : [InfoType] = [.facts,.occurance, .socialBehavior,.appearance,.diet,.sizes]
    private var activeViewIndex = 0 {
        didSet{
            collectionView?.reloadData()
        }
    }
    private var bottomConstraint = NSLayoutConstraint()
    private var dietConstraints = [NSLayoutConstraint]()
    private var habitatConstraints = [NSLayoutConstraint]()
    private var behaviorConstraints = [NSLayoutConstraint]()
    private var factConstraints = [NSLayoutConstraint]()
    private var appearanceConstraints = [NSLayoutConstraint]()
    private var sizeConstraints = [NSLayoutConstraint]()
    
    
    //MARK: Actions
    @objc func touchBackButton(){        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: Load view functions
    override func loadView() {
        super.loadView()
        setupHeading()
        setupButtons()
        setupLorizontalLine()
        setupScrollView()
        setupViewControllers()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Appearance.backgroundColor
        let name = mammalType!.shortName
        let scienceName = mammalType!.scientificName
        setHeading(to: name)
        setHeadingRight(to: scienceName ?? "")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    

}

extension DetailViewMammalsController{
    //MARK: Layout Functions
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            switch sectionNumber {
            case 0: return self.firstLayoutSection()
            default: return self.firstLayoutSection()
            }
        }
    }
    
    private func firstLayoutSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .absolute(itemHeight))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: itemSpacing, trailing: itemPadding)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
       
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = sectionLeading
        
        return section
    }
}

extension DetailViewMammalsController : UICollectionViewDelegate, UICollectionViewDataSource{
    //MARK: CollectionView Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonIcons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailTableIconCell.reuseIdentifer, for: indexPath) as! DetailTableIconCell
        var viewAsSelectedCard = false
        if indexPath.row == activeViewIndex{
            viewAsSelectedCard = true
        }
        cell.configure(withImageName: buttonIcons[indexPath.row].icon, title: buttonIcons[indexPath.row].title, asSelected: viewAsSelectedCard)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Analytics.logEvent(MyAnalyticsEvents.selected_mammalDetailedView.rawValue, parameters: [MyAnalyticsParameters.infoType.rawValue: buttonIcons[indexPath.row].rawValue])
        activeViewIndex = indexPath.row
    
        dietVC.view.isHidden = true
        habitatVC.view.isHidden = true
        sizeVC.view.isHidden = true
        appearanceVC.view.isHidden = true
        factsVC.view.isHidden = true
        behaviorVC.view.isHidden = true
        
        NSLayoutConstraint.deactivate(dietConstraints)
        NSLayoutConstraint.deactivate(habitatConstraints)
        NSLayoutConstraint.deactivate(behaviorConstraints)
        NSLayoutConstraint.deactivate(appearanceConstraints)
        NSLayoutConstraint.deactivate(factConstraints)
        NSLayoutConstraint.deactivate(sizeConstraints)
        
        switch indexPath.row {
        case 0:
            factsVC.view.isHidden = false
            NSLayoutConstraint.activate(factConstraints)
            bottomConstraint = factsVC.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Appearance.spacing)
        case 1:
            habitatVC.view.isHidden = false
            NSLayoutConstraint.activate(habitatConstraints)
            bottomConstraint = habitatVC.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Appearance.spacing)
        case 2:
            behaviorVC.view.isHidden = false
            NSLayoutConstraint.activate(behaviorConstraints)
            bottomConstraint = behaviorVC.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Appearance.spacing)
        case 3:
            appearanceVC.view.isHidden = false
            NSLayoutConstraint.activate(appearanceConstraints)
            bottomConstraint = appearanceVC.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Appearance.spacing)
        case 4:
            dietVC.view.isHidden = false
            NSLayoutConstraint.activate(dietConstraints)
            bottomConstraint = dietVC.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Appearance.spacing)
        case 5:
            sizeVC.view.isHidden = false
            NSLayoutConstraint.activate(sizeConstraints)
            bottomConstraint = sizeVC.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Appearance.spacing)
        default:
            break
            //dietVC.view.isHidden = false
            //NSLayoutConstraint.activate(dietConstraints)
            //bottomConstraint = dietVC.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Appearance.spacing)

        }
        bottomConstraint.isActive = true
        scrollView.setContentOffset(CGPoint.zero, animated: false)
    }
    
}

extension DetailViewMammalsController {
    //MARK: SetupFunctions
    private func setupViewControllers() {
        dietVC.view.translatesAutoresizingMaskIntoConstraints = false
        habitatVC.view.translatesAutoresizingMaskIntoConstraints = false
        sizeVC.view.translatesAutoresizingMaskIntoConstraints = false
        appearanceVC.view.translatesAutoresizingMaskIntoConstraints = false
        factsVC.view.translatesAutoresizingMaskIntoConstraints = false
        behaviorVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        addChild(factsVC)
        addChild(habitatVC)
        addChild(sizeVC)
        addChild(appearanceVC)
        addChild(dietVC)
        addChild(behaviorVC)
        
        scrollView.addSubview(factsVC.view)
        scrollView.addSubview(habitatVC.view)
        scrollView.addSubview(sizeVC.view)
        scrollView.addSubview(appearanceVC.view)
        scrollView.addSubview(dietVC.view)
        scrollView.addSubview(behaviorVC.view)
        
        dietVC.didMove(toParent: self)
        habitatVC.didMove(toParent: self)
        sizeVC.didMove(toParent: self)
        appearanceVC.didMove(toParent: self)
        factsVC.didMove(toParent: self)
        behaviorVC.didMove(toParent: self)
        
        dietVC.view.isHidden = true
        habitatVC.view.isHidden = true
        sizeVC.view.isHidden = true
        appearanceVC.view.isHidden = true
        //factsVC.view.isHidden = true
        behaviorVC.view.isHidden = true
        
        dietConstraints = [
            dietVC.view.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 0),
            dietVC.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            dietVC.view.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, constant: 0)
        ]
        habitatConstraints = [
            habitatVC.view.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 0),
            habitatVC.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            habitatVC.view.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, constant: 0)
        ]
        sizeConstraints = [
            sizeVC.view.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 0),
            sizeVC.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            sizeVC.view.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, constant: 0)
        ]
        appearanceConstraints = [
            appearanceVC.view.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 0),
            appearanceVC.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            appearanceVC.view.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, constant: 0)
        ]
        factConstraints = [
            factsVC.view.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 0),
            factsVC.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            factsVC.view.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, constant: 0)
        ]
        behaviorConstraints = [
            behaviorVC.view.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 0),
            behaviorVC.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            behaviorVC.view.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, constant: 0)
        ]
        //Default View which is activated
        NSLayoutConstraint.activate(factConstraints)
        bottomConstraint = factsVC.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Appearance.spacing)
        bottomConstraint.isActive = true
    }
    
    private func setupButtons(){
        // Table Buttons
        let layout = createCompositionalLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.isScrollEnabled = false
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.backgroundColor = Appearance.backgroundColor
        collectionView?.register(DetailTableIconCell.self, forCellWithReuseIdentifier: DetailTableIconCell.reuseIdentifer)
        collectionView?.reloadData()
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.isUserInteractionEnabled = true
        collectionView?.clipsToBounds = true
        view.addSubview(collectionView ?? UIView())
        NSLayoutConstraint.activate([
            collectionView!.topAnchor.constraint(equalTo: headingViewLeft.bottomAnchor,constant: spacing),
            collectionView!.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            collectionView!.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            collectionView!.heightAnchor.constraint(equalToConstant: tableHeight)
        ])
        
        // backButton
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(touchBackButton), for: .touchUpInside)
        
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: padding),
            backButton.widthAnchor.constraint(equalToConstant: backButtonWidth),
            backButton.heightAnchor.constraint(equalTo: backButton.widthAnchor,multiplier: 1)
        ])
        NSLayoutConstraint.activate([
            headingViewRight.heightAnchor.constraint(equalTo: backButton.heightAnchor),
            headingViewRight.heightAnchor.constraint(equalTo: headingViewLeft.heightAnchor)
        ])
        backButton.setImage(UIImage(named: "angle-double-up-solid")?.withTintColor(Appearance.primaryColor, renderingMode: .automatic), for: .normal)
    }
    
    private func setupHeading(){
        headingViewLeft.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headingViewLeft)
        NSLayoutConstraint.activate([
            headingViewLeft.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            headingViewLeft.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: spacing/2),
            headingViewLeft.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: leftHeadingWidthRatio),
            headingViewLeft.heightAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.heightAnchor,multiplier: leftHeadingHeightRatio)
        ])
        
        headingViewRight.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headingViewRight)
        NSLayoutConstraint.activate([
            headingViewRight.leadingAnchor.constraint(equalTo: headingViewLeft.trailingAnchor, constant: spacing),
            headingViewRight.topAnchor.constraint(equalTo: headingViewLeft.topAnchor,constant: 0),
            headingViewRight.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: rightHeadingWidthRatio),
            headingViewRight.heightAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.heightAnchor,multiplier: rightHeadingHeightRatio)
        ])
        
    }
    
    private func setHeading(to title : String) {
        let paragraphstyle = NSMutableParagraphStyle()
        paragraphstyle.alignment = .left
        paragraphstyle.hyphenationFactor = 1
        let font = Appearance.titleFont!
        let attributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: Appearance.black,
            .font: font,
            .paragraphStyle: paragraphstyle
        ]
        let attributedString = NSAttributedString(string: title, attributes: attributes)
        headingViewLeft.attributedText = attributedString
        headingViewLeft.numberOfLines = 3
        headingViewLeft.sizeToFit()
        headingViewLeft.lineBreakMode = .byClipping
        headingViewLeft.textAlignment = NSTextAlignment.left
    }
    
    private func setHeadingRight(to title : String) {
        let paragraphstyle = NSMutableParagraphStyle()
        paragraphstyle.alignment = .left
        paragraphstyle.hyphenationFactor = 1
        let font = Appearance.subheadingFont!
        let attributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: Appearance.gray,
            .font: font,
            .paragraphStyle: paragraphstyle
        ]
        
        let attributedString = NSAttributedString(string: title, attributes: attributes)
        headingViewRight.attributedText = attributedString
        headingViewRight.numberOfLines = 0
        headingViewLeft.lineBreakMode = .byClipping
        headingViewRight.textAlignment = NSTextAlignment.left
    }
    
    private func setupLorizontalLine(){
        horizontalLine.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(horizontalLine)
        NSLayoutConstraint.activate([
            horizontalLine.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            horizontalLine.topAnchor.constraint(equalTo: collectionView!.bottomAnchor,constant: spacing/2),
            horizontalLine.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: Appearance.horizontalLineWidthRatio),
            horizontalLine.heightAnchor.constraint(equalToConstant: Appearance.horizontalLineWidth)
        ])
        horizontalLine.backgroundColor = Appearance.primaryColor
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor, constant: spacing/2),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension DetailViewMammalsController {
    enum InfoType :String{
        case diet
        case facts
        case sizes
        case appearance
        case socialBehavior
        case occurance
        
        var icon : String {
            switch self {
            case .appearance: return "transgender-solid"
            case .diet: return "utensils-solid"
            case .facts: return "lightbulb-solid"
            case .socialBehavior: return "users-solid"
            case .sizes: return "paw-solid"
            case .occurance: return "map-marked-alt-solid"
            }
        }
        var title : String {
            switch self {
            case .appearance: return getLocalizedTitle(to: EtoshaViews.mammalsAppearanceView)
            case .diet: return getLocalizedTitle(to: EtoshaViews.mammalDietView)
            case .facts: return getLocalizedTitle(to: EtoshaViews.mammalsFactsView)
            case .socialBehavior: return getLocalizedTitle(to: EtoshaViews.mammalsBehaviorView)
            case .sizes: return getLocalizedTitle(to: EtoshaViews.mammalsSizeView)
            case .occurance: return getLocalizedTitle(to: EtoshaViews.mammalsHabitatView)
            }
        }
        
        func getLocalizedTitle(to etoshaView: EtoshaViews)-> String{
            let regexEnd = "_buttonText"
            return NSLocalizedString(etoshaView.rawValue+regexEnd, tableName: "Texts", bundle: .main, value: "No text found", comment: "")
        }
    }
}

