//
//  AboutUsViewController.swift
//  Etoscha
//
//  Created by Björn Roxin on 26.05.21.
//

import UIKit

class AboutUsViewController: UIViewController {
    
    //MARK: Constants
    let conceptImagePadd : CGFloat = 50
    let imageMaxHeightRatio : CGFloat = 0.4
    let andTextWith : CGFloat = 15
    let logoStackSpacing : CGFloat = 10
    
    private var scrollView = UIScrollView()
    //Top part
    private var pampletImageView = UIImageView()
    private var introLabel = UILabel()
    private var logoView = UIStackView()
    private var termiteLogoView = UIImageView()
    private var horizontalLine1 = UIView()
    
    //Concept
    private var conceptHeading = UILabel()
    private var conceptImage = UIImageView()
    private var conceptDescription = UILabel()
    private var benefitImage = UIImageView()
    private var horizontalLine2 = UIView()
    
    //Aim
    private var aimHeading = UILabel()
    private var aimImage = UIImageView()
    private var aimDescription = UILabel()
    private var endDescription = UILabel()


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Appearance.backgroundColor
        setupDefaultNavBar()
        addSingleTitleToNavBar(title: MyStrings.heading.locString)
        setupViews()
        // Do any additional setup after loading the view.
    }
    

}

extension AboutUsViewController{
    //MARK: Setup Functions
    private func setupTopImage(){
        pampletImageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: MyStrings.pamphlet.rawValue)
        if image == nil {
            print("\(MyStrings.pamphlet.rawValue) not found ")

        }
        pampletImageView.image = image
        pampletImageView.contentMode = .scaleAspectFit
        pampletImageView.clipsToBounds = true
        scrollView.addSubview(pampletImageView)
        NSLayoutConstraint.activate([
            pampletImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Appearance.spacing),
            pampletImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            //pampletImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding),
            //pampletImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Appearance.padding),
            pampletImageView.widthAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1),
            pampletImageView.widthAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7),
            
        ])
        let heightConst = pampletImageView.heightAnchor.constraint(lessThanOrEqualToConstant: view.frame.height*imageMaxHeightRatio)
        heightConst.priority = .defaultHigh
        heightConst.isActive = true
    }
    private func setupLogoViews(){
        logoView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(logoView)
        // Add logo #1
        let pAndPLogo = UIImageView()
        pAndPLogo.image = UIImage(named: MyStrings.pnpLogo.rawValue)
        pAndPLogo.contentMode = .scaleAspectFit
        let termiteLogo = UIImageView()
        termiteLogo.image = UIImage(named: MyStrings.termiteLogo.rawValue)
        termiteLogo.contentMode = .scaleAspectFit
        let andText = UILabel()
        andText.text = "&"
        logoView.addArrangedSubview(pAndPLogo)
        logoView.addArrangedSubview(andText)
        logoView.addArrangedSubview(termiteLogo)
        logoView.axis = .horizontal
        logoView.distribution = .equalSpacing
        logoView.spacing = logoStackSpacing
        
        NSLayoutConstraint.activate([
            termiteLogo.widthAnchor.constraint(equalTo: pAndPLogo.widthAnchor),
            andText.widthAnchor.constraint(equalToConstant: andTextWith)
        ])

        NSLayoutConstraint.activate([
            logoView.topAnchor.constraint(equalTo: introLabel.bottomAnchor, constant: Appearance.spacing),
            logoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding),
            logoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Appearance.padding),
        ])
    }
    private func setupConceptImage(){
        conceptImage.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(conceptImage)
        conceptImage.image = UIImage(named: MyStrings.conceptImage.rawValue)
        conceptImage.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            conceptImage.topAnchor.constraint(equalTo: conceptHeading.bottomAnchor, constant: Appearance.spacing),
            conceptImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            conceptImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: conceptImagePadd),
            conceptImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -conceptImagePadd),
        ])
    }
    private func setupBenefitImage(){
        benefitImage.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: MyStrings.benefitImage.rawValue)
        if image == nil {
            print("\(MyStrings.aimImage.rawValue) not found ")

        }
        benefitImage.image = image
        benefitImage.contentMode = .scaleAspectFit
        scrollView.addSubview(benefitImage)
        NSLayoutConstraint.activate([
            benefitImage.topAnchor.constraint(equalTo: conceptDescription.bottomAnchor, constant: Appearance.spacing),
            benefitImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            benefitImage.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            benefitImage.heightAnchor.constraint(lessThanOrEqualToConstant: view.frame.height*imageMaxHeightRatio)
        ])
    }
    private func setupAimImage(){
        aimImage.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: MyStrings.aimImage.rawValue)
        if image == nil {
            print("\(MyStrings.aimImage.rawValue) not found ")

        }
        aimImage.image = image
        aimImage.contentMode = .scaleAspectFit
        scrollView.addSubview(aimImage)
        NSLayoutConstraint.activate([
            aimImage.topAnchor.constraint(equalTo: aimHeading.bottomAnchor, constant: Appearance.spacing),
            aimImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            aimImage.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            aimImage.heightAnchor.constraint(lessThanOrEqualToConstant: view.frame.height*imageMaxHeightRatio)
        ])
    }
    
    
    
    private func setupViews(){
        Etoscha.setupScrollView(for: scrollView, parent: view)
        setupTopImage()
        setupParagraph(for: introLabel, topAnchor: pampletImageView, with: MyStrings.introText.locString, mainView: self.view, parentView: scrollView)
        setupLogoViews()
        setupLorizontalLine(for: horizontalLine1, topAnchor: logoView, mainView: self.view, parentView: scrollView)
        setupHeading(for: conceptHeading, topAnchor: horizontalLine1, with: MyStrings.conceptHeading.locString, mainView: self.view, parentView: scrollView, alignment: .center)
        setupConceptImage()
        setupParagraph(for: conceptDescription, topAnchor: conceptImage, with: MyStrings.conceptText.locString, mainView: self.view, parentView: scrollView)
        setupBenefitImage()
        setupLorizontalLine(for: horizontalLine2, topAnchor: benefitImage, mainView: self.view, parentView: scrollView)
        setupHeading(for: aimHeading, topAnchor: horizontalLine2, with: MyStrings.aimHeading.locString, mainView: self.view, parentView: scrollView, alignment: .center)
        setupAimImage()
        setupParagraph(for: aimDescription, topAnchor: aimImage, with: MyStrings.aimText.locString, mainView: self.view, parentView: scrollView)
        setupParagraph(for: endDescription, topAnchor: aimDescription, with: MyStrings.endText.locString, mainView: self.view, parentView: scrollView)
        NSLayoutConstraint.activate([
            endDescription.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Appearance.spacing)
        ])
    }
}


extension AboutUsViewController{
    //MARK: Localised Strings
    enum MyStrings:String {
        case introText = "_intro"
        case heading = "_heading"
        case conceptHeading = "_conceptHeading"
        case conceptText = "_conceptText"
        case aimText = "_aimText"
        case aimHeading = "_aimHeading"
        case endText = "_endText"
        
        //Images
        case conceptImage = "ConceptFinance"
        case benefitImage = "BenefitImage"
        case aimImage = "AimImage"
        case pnpLogo = "pAndpLogo"
        case termiteLogo = "termiteLogo"
        case pamphlet = "MammalsAndEtoshaPamplet"
        
        var locString : String {
            getLocalizedString(for: self.rawValue, viewType: EtoshaViews.aboutUs)
        }
    }
}
