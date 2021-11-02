//
//  NewMammalController.swift
//  Etoscha
//
//  Created by Björn Roxin on 28.05.21.
//

import UIKit
import CoreData
import FirebaseAnalytics

class MammalController: UIViewController {
    //MARK: Constants
    let dotsHeightRatio : CGFloat = 0.025
    let dotsWidthRatio : CGFloat = 0.4
    let shortInfoHeightRatio : CGFloat = 0.3
    let detailButtonWidthRatio : CGFloat = 0.18
    let aspectRatio : CGFloat = 1.5
    
    //MARK: Views
    private var imageView : UIImageViewBluredBackground?
    private var shortInfoView : MammalProfileInfoView?
    private let gradientView = UIView()
    private var gradientLayer = CAGradientLayer()
    private var toDetailViewButton : UIButton?
    private var markAsSeenButton : UIButton?
    private var dots : DotsView?
    private let detailedHeading = MammalsHeadingViewController()
    private let bottomHeadingGradientView = GradientView()
    
    //MARK: Data
    var delegate: MammalToSights?
    var mammalType : MammalType? {
        didSet{
            detailedHeading.setHeading(name: mammalType!.shortName, scientificName: mammalType!.scientificName ?? "")
        }
    }
    
    // Reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var mammal : Mammal? {
        didSet {
            guard mammal != nil else {
                return
            }
            markAsSeenButton?.isSelected = mammal!.isSeen
        }
    }
        
    private var imageNames = [LabeledImage]()
    private var shortInfos : [(UIImage,String)] {
        //Name info
        let nameIcon = UIImage(named: self.mammalType!.shape)
        
        // Scientific name
        let scienceText = mammalType!.scientificName

        // Lifespan Info
        let lifespanImage = UIImage(named: "heartbeat-solid")!
        let lifespanText = mammalType!.lifespan
        
        // Weight Info
        let weightImage = UIImage(named: "balance-scale-solid")!
        let weighText = mammalType!.weight
        
        // Speed Info
        let speedImage = UIImage(named: "tachometer-alt-solid")!
        let speedText = mammalType!.speed
        
        // Activity
        let activityImage = UIImage(named: mammalType!.activity.image)!
        let activityText = mammalType!.activity.name
        
        // Diet
        let dietImage = UIImage(named: "utensils-solid")!
        var dietArrayText = [String]()
        for diet in mammalType!.diet{
            dietArrayText.append(diet.name)
        }
        let dietText = dietArrayText.joined(separator: ", ")

        var toBeReturned = [(nameIcon,scienceText),(lifespanImage,lifespanText),(weightImage,weighText),(speedImage,speedText),(activityImage,activityText), (dietImage,dietText)].filter({$0.0 != nil && $0.1 != ""}) //as! [(UIImage, String)]
        if mammalType!.longName != mammalType!.shortName && nameIcon != nil {
            toBeReturned.insert((nameIcon!,mammalType!.longName),at: 1)
        }
        return toBeReturned as! [(UIImage, String)]
    }
    
    private var slideNumber : Int = 0 {
        didSet{
            let rightestIndexValue = imageNames.count - 1
            if imageNames.count != 0 {
                // Reached left boundary -> choose rightest image
                if slideNumber < 0 {
                    slideNumber = rightestIndexValue
                    // Reached right boundary --> choose first image
                }else if slideNumber > rightestIndexValue {
                    slideNumber = 0
                }
                activateSide(with: slideNumber)
            }
        }
    }
    
    //MARK: private Functions
    private func loadImages(){
        guard mammalType != nil else {return }
        imageNames = mammalType!.labeledImages
        if imageNames.count == 1 {
            imageNames.append(imageNames.last!)
        }
        assert(imageNames.count > 0, "Min 1 image must be available")
    }
    
    private func loadInfo(){
        
    }

    private func activateSide(with number: Int) {
        imageView?.configure(withLabeldImage: imageNames[slideNumber],viewSize: self.view.bounds.size)
        let middle = shortInfos.count / 2
        if number == 0
        {
            shortInfoView?.info = shortInfos[..<middle].map({$0})
        }
        else {
            shortInfoView?.info = shortInfos[middle...].map({$0})
        }
        if imageNames.count == 1 {
            shortInfoView?.info = shortInfos[..<middle].map({$0})
        }
        dots?.activeDot = number
    }
    
    //MARK: Actions
    @objc func markAsSeenTabbed() {
        Analytics.logEvent(MyAnalyticsEvents.markAsSeenMammal.rawValue, parameters: [MyAnalyticsParameters.mammalType.rawValue : self.mammalType!.rawValue,
                                                                                     MyAnalyticsParameters.markedAsSeenOrigin.rawValue: MarkAsSeenOrigin.Tickbox.rawValue])
        swapMammalsIsSeen()
        delegate?.changeInMammalSeenStatus()
        
        // update medals
//        let newMedalAchievements = foundNewAchievedMedal()
//        for medal in newMedalAchievements{
//            print("New Medal \(medal.rawValue) achieved")
//        }
//        if newMedalAchievements.isEmpty == false {
//            performSegue(withIdentifier: "newTrophy", sender: newMedalAchievements.first)
//        }
    }
    
    @objc func touchDetailButton() {
        let detailVC = DetailViewMammalsController()
        detailVC.mammalType = self.mammalType
        present(detailVC, animated: true, completion: nil)
    }
    
    @objc func imageDoubleClicked(){
        Analytics.logEvent(MyAnalyticsEvents.markAsSeenMammal.rawValue, parameters: [MyAnalyticsParameters.mammalType.rawValue : self.mammalType!.rawValue,
                                                                                     MyAnalyticsParameters.markedAsSeenOrigin.rawValue: MarkAsSeenOrigin.DoubleClick.rawValue])
        swapMammalsIsSeen()
    }
    
    @objc func swipeRecognised(_ sender: UISwipeGestureRecognizer){
        switch sender.direction {
        case .right:
            slideNumber -= 1
        case .left:
            slideNumber += 1
        default:
            break
        }
    }
    
    //MARK: Load View Functions
    override func loadView() {
        super.loadView()
        view.backgroundColor = Appearance.backgroundColor
        assert(mammalType != nil, "Animal not loaded")
        setupDefaultNavBar()
        if let numberOfViewControllers = self.navigationController?.viewControllers.count, let sightController = self.navigationController?.viewControllers[numberOfViewControllers - 2] as? SightsViewController{
            delegate = sightController
        }
        addSingleTitleToNavBar(title: mammalType!.shortName)
        //addDoubleTitleToNavBar(title:  mammalType!.shortName, subtitle: mammalType!.scientificName ?? "") // Contains bug
        loadImages()
        loadInfo()
        fetchAnimal()
        setupSeenButton()
        setupViews()
        setupConstraints()
        //setupDetailedHeading()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView?.backgroundColor = mammalType?.backgroundColor
        toDetailViewButton?.setImage(UIImage(named: "angle-double-down-solid")?.withTintColor(UIColor.white, renderingMode: .automatic), for: .normal)
        toDetailViewButton?.addTarget(self, action: #selector(touchDetailButton), for: .touchUpInside)
        addGestures()
        imageView?.configure(withLabeldImage: imageNames[slideNumber],viewSize: self.view.bounds.size)

        // ShortInfo View
        activateSide(with: 0)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = gradientView.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dots?.layoutSubviews()
        dots?.isHidden = false
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewMammalsController{
            destination.mammalType = self.mammalType
        }
    }
}

extension MammalController {
    //MARK: Core Data Functions
    private func fetchAnimal() {
        guard mammalType != nil else {return}
        do {
            let request = Mammal.fetchRequest() as NSFetchRequest<Mammal>
            let predicate = NSPredicate(format: "mammaltypeValue CONTAINS %@", self.mammalType!.rawValue)
            request.predicate = predicate
            let foundMammals = try context.fetch(request)
            assert(foundMammals.count <= 1, "Sould not have more than 1 \(self.mammalType!.rawValue) in CoreData")
            if foundMammals.count >= 1{
                self.mammal = foundMammals.first
            }
        }catch{
            print("No \(self.mammalType!.rawValue) found in CoreData")
            print("Add \(self.mammalType!.rawValue) to CoreData")
        }
    }
    

    private func swapMammalsIsSeen(){
        // edit Mammal
        mammal!.isSeen = !mammal!.isSeen
        
        //save data
        do {
            try self.context.save()
        }catch {
            
        }
        // fetch data
        self.fetchAnimal()
    }
}

extension MammalController{
    //MARK: Setup Functions
    func setupSeenButton() {
        markAsSeenButton = UIButton()
        let unselectedImage = UIImage(named: "binoculars-solid")?.withTintColor(Appearance.primaryColor)//Tick_unticked_small
        let selectedImage = UIImage(named: "Tick_ticked_small")
        markAsSeenButton!.setImage(unselectedImage, for: .normal)
        markAsSeenButton!.setImage(selectedImage, for: .selected)
        markAsSeenButton!.addTarget(self, action: #selector(markAsSeenTabbed), for: .touchUpInside)
        markAsSeenButton!.isSelected = mammal!.isSeen
        let rightBarButton = UIBarButtonItem(customView: markAsSeenButton!)
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func setupViews(){
        imageView = UIImageViewBluredBackground()
        imageView!.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView ??  UIImageViewBluredBackground())
        
        shortInfoView = MammalProfileInfoView()
        shortInfoView?.translatesAutoresizingMaskIntoConstraints = false
        imageView!.addSubview(shortInfoView ??  UIView())
        
        toDetailViewButton = UIButton()
        toDetailViewButton?.translatesAutoresizingMaskIntoConstraints = false
        imageView!.addSubview(toDetailViewButton ?? UIButton())
        
        assert(imageNames.count > 0, "Images not loaded, dots cannot be shown")
        dots = DotsView(frame: CGRect.zero, numberOfDots: imageNames.count)
        dots!.translatesAutoresizingMaskIntoConstraints = false
        dots?.isHidden = true
        imageView!.addSubview(dots!)
        
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        imageView!.addSubview(gradientView)
        gradientView.layer.addSublayer(gradientLayer)
        gradientLayer.colors = [ #colorLiteral(red: 0.5735062957, green: 0.5583232045, blue: 0.5871592164, alpha: 0.1148492518).cgColor,#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor]
        gradientLayer.opacity = 0.5
        
        imageView!.bringSubviewToFront(toDetailViewButton!)
        imageView?.bringSubviewToFront(shortInfoView!)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            imageView!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView!.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageView!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView!.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: 0)//-Appearance.spacing*5),
        ])
        NSLayoutConstraint.activate([
            toDetailViewButton!.trailingAnchor.constraint(equalTo: imageView!.trailingAnchor, constant: -Appearance.spacing),
            toDetailViewButton!.bottomAnchor.constraint(equalTo: imageView!.safeAreaLayoutGuide.bottomAnchor,constant: -Appearance.padding),
            toDetailViewButton!.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: detailButtonWidthRatio),
            toDetailViewButton!.heightAnchor.constraint(equalTo: toDetailViewButton!.widthAnchor,multiplier: 1)
        ])
        NSLayoutConstraint.activate([
            shortInfoView!.leadingAnchor.constraint(equalTo: imageView!.leadingAnchor, constant: 0),
            shortInfoView!.trailingAnchor.constraint(equalTo: toDetailViewButton!.leadingAnchor,constant: -Appearance.padding/3),
            shortInfoView!.heightAnchor.constraint(greaterThanOrEqualTo: imageView!.heightAnchor, multiplier: shortInfoHeightRatio),
            shortInfoView!.bottomAnchor.constraint(equalTo: imageView!.bottomAnchor, constant: 0),
        ])
        NSLayoutConstraint.activate([
            gradientView.leadingAnchor.constraint(equalTo: imageView!.leadingAnchor, constant: 0),
            gradientView.trailingAnchor.constraint(equalTo: imageView!.trailingAnchor,constant: 0),
            gradientView.topAnchor.constraint(equalTo: shortInfoView!.topAnchor),
            gradientView.bottomAnchor.constraint(equalTo: imageView!.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            dots!.topAnchor.constraint(equalTo: imageView!.topAnchor, constant: Appearance.spacing),
            dots!.centerXAnchor.constraint(equalTo: imageView!.centerXAnchor),
            dots!.widthAnchor.constraint(equalTo: imageView!.widthAnchor,multiplier: dotsWidthRatio),
            dots!.heightAnchor.constraint(equalTo: imageView!.heightAnchor,multiplier: dotsHeightRatio)
        ])
    }
    
    private func setupDetailedHeading(){
        detailedHeading.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(detailedHeading)
        self.view.addSubview(detailedHeading.view)
        detailedHeading.didMove(toParent: self)
        NSLayoutConstraint.activate([
            detailedHeading.view.topAnchor.constraint(equalTo: imageView!.bottomAnchor),
            detailedHeading.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            detailedHeading.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            detailedHeading.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        bottomHeadingGradientView.translatesAutoresizingMaskIntoConstraints = false
        detailedHeading.view.addSubview(bottomHeadingGradientView)
        NSLayoutConstraint.activate([
            bottomHeadingGradientView.topAnchor.constraint(equalTo: detailedHeading.view.topAnchor),
            bottomHeadingGradientView.leadingAnchor.constraint(equalTo: detailedHeading.view.leadingAnchor),
            bottomHeadingGradientView.trailingAnchor.constraint(equalTo: detailedHeading.view.trailingAnchor),
            bottomHeadingGradientView.bottomAnchor.constraint(equalTo: detailedHeading.view.bottomAnchor)
        ])
        bottomHeadingGradientView.setColors(first: #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 0.6).cgColor, second: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor, opacity: 1)
    }
    
    func addGestures(){
        // Add Gesture to main Image
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeRecognised(_:)))
        swipeRightGesture.direction = .right
        swipeRightGesture.numberOfTouchesRequired = 1
        imageView?.addGestureRecognizer(swipeRightGesture)
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeRecognised(_:)))
        swipeLeftGesture.direction = .left
        imageView?.addGestureRecognizer(swipeLeftGesture)
        
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(touchDetailButton))
        swipeUpGesture.direction = .up
        shortInfoView!.addGestureRecognizer(swipeUpGesture)
        
        let imageDoubleClickGesture = UITapGestureRecognizer(target: self, action: #selector(imageDoubleClicked))
        imageDoubleClickGesture.numberOfTapsRequired = 2
        imageView?.addGestureRecognizer(imageDoubleClickGesture)
        
        let tabDetailGesture = UITapGestureRecognizer(target: self, action: #selector(touchDetailButton))
        tabDetailGesture.numberOfTapsRequired = 1
        tabDetailGesture.numberOfTouchesRequired = 1
        shortInfoView?.addGestureRecognizer(tabDetailGesture)
        
        imageView?.isUserInteractionEnabled = true
    }
}


protocol MammalToSights {
    func changeInMammalSeenStatus()
}
