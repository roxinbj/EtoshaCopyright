//
//  HomeViewController.swift
//  Etoscha
//
//  Created by Björn Roxin on 18.03.21.
//

import UIKit
import Firebase

class HomeViewControllerV2: UIViewController {
    
    // Views
    private var titleBar = UIView()
    private var scrollView = UIScrollView()
    private var titleView = UILabel()
    private var subTitleView = UILabel()
    private var cardsView = UIStackView()
    private var settingsButton = UIButton()
    
    // Data
    private var cards : [HomeCards] = HomeCards.allCases
    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    //MARK: Load View
    override func loadView() {
        super.loadView()
        // Only for development / debug purposes
        //resetApp()
        initCoreData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Appearance.backgroundColor
        // Setup Title
        
        setupTitleBar()
        setupScrollView()
        setupTitle()
        setupSettingsButton()
        //setupSupTitle()
        setupCards()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.setContentOffset(CGPoint.zero, animated: false)
        
        if Core.shared.isNewUser(){
            do{
                sleep(1)
            }
            self.view.backgroundColor = Appearance.backgroundColor.withAlphaComponent(0.5)
            let onboardingVC = storyboard?.instantiateViewController(identifier: "onboardingNav") as! UINavigationController
            onboardingVC.modalPresentationStyle = .fullScreen
            present(onboardingVC,animated: true)
        }
        view.backgroundColor = Appearance.backgroundColor

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        navigationController?.setNavigationBarHidden(true, animated: false)
        AppUtility.lockOrientation(.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

extension HomeViewControllerV2 {
    //MARK: Setup Views
    private func setupTitleBar(){
        titleBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(titleBar)
        NSLayoutConstraint.activate([
            titleBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            titleBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            titleBar.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
            titleBar.heightAnchor.constraint(greaterThanOrEqualTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.02)
        ])
        titleBar.isUserInteractionEnabled = true
        //titleBar.backgroundColor = Appearance.primaryColor.withAlphaComponent(0.1)
    }
    
    private func setupTitle(){
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleBar.addSubview(titleView)
        let paragraphstyle = NSMutableParagraphStyle()
        paragraphstyle.alignment = .center
        paragraphstyle.hyphenationFactor = 1
        
        let attributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: Appearance.black,
            .font: UIFontMetrics(forTextStyle: .title1).scaledFont(for: UIFont(name: Appearance.semiBold, size: 18)!),
            .paragraphStyle: paragraphstyle
            ]
        let etoshaAppString = "Etosha App"
        let attributedString = NSAttributedString(string: etoshaAppString, attributes: attributes)
        titleView.attributedText = attributedString
        titleView.numberOfLines = 0
        titleView.sizeToFit()
        titleView.textAlignment = NSTextAlignment.center
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: titleBar.topAnchor, constant: Appearance.spacing/2),
            titleView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding),
            titleView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Appearance.padding),
            titleView.bottomAnchor.constraint(equalTo: titleBar.bottomAnchor, constant: -Appearance.spacing/2),
        ])
        titleView.isUserInteractionEnabled = true
        
        //let tabGesture = UITapGestureRecognizer(target: self, action: #selector(titleClicked))
        //tabGesture.numberOfTouchesRequired = 1
        //tabGesture.numberOfTapsRequired = 1
        //titleView.addGestureRecognizer(tabGesture)
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isDirectionalLockEnabled = true
        self.view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: titleBar.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    private func setupSupTitle(){
        subTitleView.translatesAutoresizingMaskIntoConstraints = false
        titleBar.addSubview(subTitleView)
        let paragraphstyle = NSMutableParagraphStyle()
        paragraphstyle.alignment = .center
        paragraphstyle.hyphenationFactor = 1
        let subAttributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: Appearance.primaryColor,
            .font: UIFontMetrics(forTextStyle: .title2).scaledFont(for: UIFont(name: Appearance.medium, size: 20)!),
            .paragraphStyle: paragraphstyle
        ]
        subTitleView.attributedText = NSAttributedString(string: MyStrings.welcomeSubHeading.locString, attributes: subAttributes)
        subTitleView.numberOfLines = 0
        subTitleView.sizeToFit()
        subTitleView.textAlignment = NSTextAlignment.center
        NSLayoutConstraint.activate([
            subTitleView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: Appearance.spacing/2),
            subTitleView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding),
            subTitleView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Appearance.padding),
        ])
        subTitleView.isUserInteractionEnabled = true
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(titleClicked))
        tabGesture.numberOfTouchesRequired = 1
        tabGesture.numberOfTapsRequired = 1
        subTitleView.addGestureRecognizer(tabGesture)
    }
    
    private func setupSettingsButton() {
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        titleBar.addSubview(settingsButton)
        settingsButton.setImage(UIImage(named: "3lines")!.withRenderingMode(.automatic).withTintColor(Appearance.primaryColor), for: .normal)
        settingsButton.addTarget(self, action: #selector(pushSettings), for: .touchUpInside)
        NSLayoutConstraint.activate([
            settingsButton.topAnchor.constraint(equalTo: titleBar.topAnchor),
            settingsButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding),
            settingsButton.bottomAnchor.constraint(equalTo: titleBar.bottomAnchor)
        ])
    }
    
    @objc private func pushSettings(){
        let vc = SettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private func setupCards(){
        cardsView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(cardsView)
        cardsView.distribution = .fillEqually
        cardsView.axis = .vertical
        cardsView.alignment = .center
        cardsView.spacing = Appearance.spacing/3
        for index in cards.indices{
            let card = cards[index]
            let cardView = Card()
            cardView.translatesAutoresizingMaskIntoConstraints = false
            cardView.configure(withImageName: card.mainImage, title: card.shortName, asSmallCard: false)
            let tabGesture = UITapGestureRecognizer(target: self, action: #selector(cardClicked(_:)))
            tabGesture.numberOfTouchesRequired = 1
            tabGesture.numberOfTapsRequired = 1
            cardView.addGestureRecognizer(tabGesture)
            cardView.tag = index
            let aspectRatioCard :CGFloat = 2

            cardsView.addArrangedSubview(cardView)
            NSLayoutConstraint.activate([
                cardView.widthAnchor.constraint(equalTo: cardsView.widthAnchor, multiplier: 1),
                cardView.heightAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 1/aspectRatioCard)
            ])
        }
        NSLayoutConstraint.activate([
            cardsView.topAnchor.constraint(equalTo: scrollView.topAnchor),//Appearance.spacing),
            cardsView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: Appearance.padding/2),
            cardsView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: -Appearance.padding/2),
            cardsView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: -Appearance.spacing),
        ])
    }
    
    @objc private func titleClicked(){
        print("Tutl clicked")
        let vc = WelcomeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func cardClicked(_ recogniser: UITapGestureRecognizer){
        let tag = recogniser.view!.tag
        print("Tag: \(tag)")
        switch tag {
        case 0:
            let vc = MammalCollectionViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = SightsViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = MapViewController()
            vc.focusCamp = .Okaukuejo
            navigationController?.pushViewController(vc, animated: true)
        default: return
        }
    }
    
}

extension HomeViewControllerV2 {
    //MARK: Core Data
    private func resetApp(){
        print("Reset App")
        do{
            let stats = try context.fetch(Onboarding.fetchRequest()) as [Onboarding]
            for stat in stats{
                context.delete(stat)
            }
            
            try self.context.save()
        }catch {
            print("Reset of App failed")
        }
        
        //Switch Onboarding on
        Core.shared.reset()
        
        // Set User Defaults
        let defaults = UserDefaults.standard
        defaults.set(0,forKey: .reviewWorthyActionCount)
        defaults.set(0,forKey: .appStartupsActionCount)
    }
    
    private func initCoreData(){
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

extension HomeViewControllerV2{
    enum MyStrings :String {
        case welcomeHeading = "_welcomeHeading";
        case welcomeSubHeading = "_welcomeSubHeading";
        var locString : String {
            getLocalizedString(for: self.rawValue, viewType: EtoshaViews.homeView)
        }
    }
}

class Core{
    static let shared = Core()
    
    func isNewUser() -> Bool{
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func setIsNotNewUser(){
        UserDefaults.standard.set(true,forKey: "isNewUser")
    }
    func reset(){
        UserDefaults.standard.set(false,forKey: "isNewUser")
    }
}
