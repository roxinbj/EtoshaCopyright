//
//  Onboarding5ViewController.swift
//  Etoscha
//
//  Created by Björn Roxin on 17.08.21.
//

import UIKit

class Onboarding5ViewController: OnboardingBaseViewController {

    //MARK: Views
    private var firstLabel : UILabel?
    private var secondLabel : UILabel?
    private var thirdLabel : UILabel?
    private var fourthLabel : UILabel?
    
    override func loadView() {
        super.loadView()
        solidDotIndex = 4
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let heading = NSMutableAttributedString(string: MyStrings.titleBold.locString, attributes: headingBoldAttributes)
        heading.append(NSMutableAttributedString(string: MyStrings.titleNormal.locString, attributes: headingNormalAttributes))
        setTitle(with: heading)
        setImage(with: "Onboarding/InfoScreen")
        setupFirstLabel()
        setupSecondLabel()
        setupThirdLabel()
        setupTopCircle()
        nextButton.setAttributedTitle(NSAttributedString(string: NSLocalizedString("OnboardingButtonDone", tableName: "Texts", bundle: .main, value: ErrorHandler.localizedStringNotFound, comment: "Loc String"), attributes:
                                                            [.foregroundColor: Appearance.primaryColor,
                                                             .font: UIFont(name: Appearance.regular, size: 24)!]), for: .normal)
        // Do any additional setup after loading the view.
    }
    
    
    override func touchNextButton(){
        closeOnboarding()
    }
    
    //MARK: Setup Functions
    private func setupFirstLabel(){
        let spaceHolder = UIView()
        spaceHolder.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(spaceHolder)
        NSLayoutConstraint.activate([
            spaceHolder.topAnchor.constraint(equalTo: imageView.topAnchor),
            spaceHolder.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.15),
            spaceHolder.leadingAnchor.constraint(equalTo: imageView.trailingAnchor),
            spaceHolder.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        firstLabel = UILabel()
        contentView.addSubview(firstLabel!)
        firstLabel!.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstLabel!.topAnchor.constraint(equalTo: spaceHolder.bottomAnchor),
            firstLabel!.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Appearance.padding/2),
            firstLabel!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Appearance.padding/2)
        ])
        
        let attributedString = NSMutableAttributedString(string:MyStrings.FirstBold.locString, attributes: paragraphBoldAttributes)
        attributedString.append(NSMutableAttributedString(string:MyStrings.FirstNormal.locString, attributes: paragraphNormalAttributes))
        
        firstLabel!.attributedText = attributedString
        firstLabel!.numberOfLines = 0
        firstLabel!.textAlignment = .center
    }
    
    private func setupSecondLabel(){
        let spaceHolder = UIView()
        spaceHolder.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(spaceHolder)
        NSLayoutConstraint.activate([
            spaceHolder.topAnchor.constraint(equalTo: firstLabel!.bottomAnchor),
            spaceHolder.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.12),
            spaceHolder.leadingAnchor.constraint(equalTo: imageView.trailingAnchor),
            spaceHolder.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        secondLabel = UILabel()
        contentView.addSubview(secondLabel!)
        secondLabel!.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            secondLabel!.topAnchor.constraint(equalTo: spaceHolder.bottomAnchor),
            secondLabel!.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Appearance.padding/2),
            secondLabel!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Appearance.padding/2)
        ])
               
        let attributedString = NSMutableAttributedString(string:MyStrings.SecondNormal.locString, attributes: paragraphNormalAttributes)
        attributedString.append(NSMutableAttributedString(string:MyStrings.SecondBold.locString, attributes: paragraphBoldAttributes))
        
        secondLabel!.attributedText = attributedString
        secondLabel!.numberOfLines = 0
        secondLabel!.textAlignment = .center
    }
    private func setupThirdLabel(){
        let spaceHolder = UIView()
        spaceHolder.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(spaceHolder)
        NSLayoutConstraint.activate([
            spaceHolder.topAnchor.constraint(equalTo: secondLabel!.bottomAnchor),
            spaceHolder.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.12),
            spaceHolder.leadingAnchor.constraint(equalTo: imageView.trailingAnchor),
            spaceHolder.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        thirdLabel = UILabel()
        contentView.addSubview(thirdLabel!)
        thirdLabel!.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            thirdLabel!.topAnchor.constraint(equalTo: spaceHolder.bottomAnchor),
            thirdLabel!.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Appearance.padding/2),
            thirdLabel!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Appearance.padding/2)
        ])
        
        let returnedString = NSMutableAttributedString(string:MyStrings.ThirdBold.locString, attributes: paragraphBoldAttributes)
        returnedString.append(NSMutableAttributedString(string: MyStrings.ThirdNormal.locString, attributes: paragraphNormalAttributes))
        
        thirdLabel!.attributedText = returnedString
        thirdLabel!.numberOfLines = 0
        thirdLabel!.textAlignment = .center
    }

    private func setupTopCircle(){
        let spaceHolder = UIView()
        spaceHolder.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(spaceHolder)
        NSLayoutConstraint.activate([
            spaceHolder.topAnchor.constraint(equalTo: imageView.topAnchor),
            spaceHolder.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.9),
            spaceHolder.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            spaceHolder.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.75)
        ])
        
        let circle = Dot()
        imageView.addSubview(circle)
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.layer.borderWidth = 3
        circle.layer.borderColor = UIColor.orange.cgColor
        NSLayoutConstraint.activate([
            circle.topAnchor.constraint(equalTo: spaceHolder.bottomAnchor),
            circle.leadingAnchor.constraint(equalTo: spaceHolder.trailingAnchor),
            circle.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.2),
            circle.heightAnchor.constraint(equalTo: circle.widthAnchor, multiplier: 1)
        ])

    }
}

extension Onboarding5ViewController{
    enum MyStrings :String {
        case titleBold = "TitleBold"
        case titleNormal = "TitleNormal"
        case FirstBold = "1Bold"
        case FirstNormal = "1Normal"
        case SecondBold = "2Bold"
        case SecondNormal = "2Normal"
        case ThirdBold = "3Bold"
        case ThirdNormal = "3Normal"
        var locString : String {
            return NSLocalizedString("Onboarding5_" + self.rawValue, tableName: "Texts", bundle: .main, value: ErrorHandler.localizedStringNotFound, comment: "Loc String")
        }
    }
}


