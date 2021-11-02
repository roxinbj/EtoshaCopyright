//
//  OnboardingViewController.swift
//  Etoscha
//
//  Created by Björn Roxin on 13.08.21.
//

import UIKit

class OnboardingBaseViewController: UIViewController {

    //MARK: Public Variables and Functions
    public var solidDotIndex : Int = 0
    
    public lazy var paragraphBoldAttributes = [NSAttributedString.Key.font : UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: Appearance.semiBold,size: self.textSize)!), NSAttributedString.Key.foregroundColor: UIColor.white]
    public lazy var paragraphNormalAttributes =  [NSAttributedString.Key.font : UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: Appearance.regular,size: self.textSize)!),NSAttributedString.Key.foregroundColor: UIColor.white]
    public lazy var headingBoldAttributes = [NSAttributedString.Key.font : UIFontMetrics(forTextStyle: .title1).scaledFont(for: UIFont(name: Appearance.bold,size: self.headingSize)!), NSAttributedString.Key.foregroundColor: UIColor.white]
    public lazy var headingNormalAttributes =  [NSAttributedString.Key.font : UIFontMetrics(forTextStyle: .title2).scaledFont(for: UIFont(name: Appearance.regular,size: self.textSize)!),NSAttributedString.Key.foregroundColor: UIColor.white]
    
    
    public func setTitle(with string: NSMutableAttributedString){
        let paragraphstyle = NSMutableParagraphStyle()
        paragraphstyle.alignment = .center
        let attString = string
        attString.addAttribute(.paragraphStyle, value: paragraphstyle, range: NSMakeRange(0, attString.length))
        titleView.attributedText = attString
        titleView.numberOfLines = 0
        titleView.lineBreakMode = .byClipping
        titleView.adjustsFontSizeToFitWidth = true
        titleView.minimumScaleFactor = 0.8
    }

    public func setImage(with imageName: String){
        let image = UIImage(named: imageName)
        imageView.image = image
        let aspectRatio = image!.size.width / image!.size.height
        imageWidth = imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: aspectRatio)//multiplier: 0.54)
        
        imageHeight = imageView.widthAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5)
    
        imageHeight!.isActive = true
        imageWidth!.isActive = true
    }
    public func setNextButton(with name: String){
        nextButton.setAttributedTitle(NSAttributedString(string: name, attributes:
                                                            [.foregroundColor: Appearance.primaryColor,
                                                             .font: UIFont(name: Appearance.semiBold, size: 30)!]), for: .normal)
    }
    
    //MARK: Views
    public var contentView = UIView()
    public let titleView = UILabel()
    public var titleLine = UIView()
    public var imageView = UIImageView()
    public var nextButton = UIButton()
    public var exitButton = UIButton()

    public var dots = DotsView(frame: .zero, numberOfDots: 5)
    
    //MARK: Constraints
    private var imageHeight : NSLayoutConstraint?
    private var imageWidth : NSLayoutConstraint?
    let dotsHeightRatio : CGFloat = 0.025
    let dotsWidthRatio : CGFloat = 0.4
    let headingSize : CGFloat = 30
    let textSize : CGFloat = 18
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = Appearance.backgroundColor.withAlphaComponent(0.5)
        setupContentView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupTitle()
        //Etoscha.setupLorizontalLine(for: titleLine, topAnchor: titleView, mainView: self.view, parentView: self.view)
        setupNextButton()
        setupExitButton()
        setupDots()
        setupFirstImage()
        dots.activeDot = solidDotIndex
        addGesture()
        contentView.sendSubviewToBack(imageView)

    }
    
    func addGesture(){
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
        swipeLeft.direction = .left
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
        swipeRight.direction = .right
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeDown))
        swipeDown.direction = .down
                
        self.view.addGestureRecognizer(swipeLeft)
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeDown)
    }
   
    public func closeOnboarding(){
        Core.shared.setIsNotNewUser()
        dismiss(animated: true, completion: nil)
    }
    
    @objc public func touchNextButton(){
    }
    @objc public func swipeLeft(){
        touchNextButton()
    }
    @objc public func swipeRight(){
        navigationController?.popViewController(animated: false)
    }
    @objc public func swipeDown(){
        closeOnboarding()
    }

    @objc private func touchedExitButton(){
        closeOnboarding()
    }
    //MARK: Setup
    private func setupContentView(){
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(contentView)
        contentView.backgroundColor = Appearance.primaryColor
        contentView.layer.cornerRadius = 5
        let distance : CGFloat = 5
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: distance),
            contentView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: distance),
            contentView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -distance),
            contentView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -distance),
        ])
    }
    private func setupTitle(){
        titleView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(titleView)
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Appearance.spacing/2),
            titleView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 1.5*Appearance.padding),
            titleView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -1.5*Appearance.padding),
        ])
        titleView.sizeToFit()
    }
    private func setupExitButton(){
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(exitButton)
        exitButton.setImage(UIImage(named: "times-circle-solid")!.withRenderingMode(.automatic).withTintColor(UIColor.white), for: .normal)
        exitButton.addTarget(self, action: #selector(touchedExitButton), for: .touchUpInside)
        NSLayoutConstraint.activate([
            exitButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Appearance.spacing/2),
            exitButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -1.5/Appearance.padding),
            exitButton.widthAnchor.constraint(equalToConstant: 44),
            exitButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    private func setupNextButton(){
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(nextButton)
        nextButton.setAttributedTitle(NSAttributedString(string: NSLocalizedString("OnboardingButtonNext", tableName: "Texts", bundle: .main, value: ErrorHandler.localizedStringNotFound, comment: "Loc String"), attributes:
                                                            [.foregroundColor: Appearance.primaryColor,
                                                             .font: UIFont(name: Appearance.regular, size: 24)!]), for: .normal)
        nextButton.addTarget(self, action: #selector(touchNextButton), for: .touchUpInside)
        nextButton.backgroundColor = Appearance.backgroundColor
        nextButton.backgroundColor = Appearance.backgroundColor
        nextButton.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -Appearance.spacing),
            nextButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding),
            nextButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Appearance.padding),
            nextButton.heightAnchor.constraint(equalTo: nextButton.widthAnchor, multiplier: 0.12)
        ])
    }
    private func setupFirstImage(){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        setImage(with: "Onboarding/MammalCategoryLevel1")
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: Appearance.spacing),
            imageView.bottomAnchor.constraint(lessThanOrEqualTo: dots.topAnchor, constant: -Appearance.spacing),
            imageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding/2),
            imageView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: 0)
        ])
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.black.cgColor
    }
    
    private func setupDots(){
        dots.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(dots)
        NSLayoutConstraint.activate([
            dots.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -Appearance.spacing),
            dots.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            dots.widthAnchor.constraint(equalTo: self.view.widthAnchor,multiplier: dotsWidthRatio),
            dots.heightAnchor.constraint(equalTo: self.view.heightAnchor,multiplier: dotsHeightRatio/1.5)
        ])
        
    }
}
