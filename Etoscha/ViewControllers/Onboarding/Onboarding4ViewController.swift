//
//  Onboarding4ViewController.swift
//  Etoscha
//
//  Created by Björn Roxin on 17.08.21.
//

import UIKit

class Onboarding4ViewController: OnboardingBaseViewController {
    //MARK: Views
    private var firstLabel : UILabel?
    private var secondLabel : UILabel?
    private var thirdLabel : UILabel?
    private var fourthLabel : UILabel?
    
    override func loadView() {
        super.loadView()
        solidDotIndex = 3
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let heading = NSMutableAttributedString(string: MyStrings.titleBold.locString, attributes: headingBoldAttributes)
        heading.append(NSMutableAttributedString(string: MyStrings.titleNormal.locString, attributes: headingNormalAttributes))
        setTitle(with: heading)
        setImage(with: "Onboarding/MapScreen")
        setupFirstLabel()
        setupSecondLabel()
        setupTopCircle()

        // Do any additional setup after loading the view.
    }
    
    
    override func touchNextButton(){
        let vc = Onboarding5ViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
    
    //MARK: Setup Functions
    private func setupFirstLabel(){
        let spaceHolder = UIView()
        spaceHolder.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(spaceHolder)
        NSLayoutConstraint.activate([
            spaceHolder.topAnchor.constraint(equalTo: imageView.topAnchor),
            spaceHolder.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.25),
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
        
        let attributedString = NSMutableAttributedString(string: MyStrings.FirstBold.locString, attributes: paragraphBoldAttributes)
        attributedString.append(NSMutableAttributedString(string: MyStrings.FirstNormal.locString, attributes: paragraphNormalAttributes))
        
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
            spaceHolder.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.2),
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
               
        let attributedString = NSMutableAttributedString(string: MyStrings.SecondBold.locString, attributes: paragraphBoldAttributes)
        attributedString.append(NSMutableAttributedString(string: MyStrings.SecondNormal.locString, attributes: paragraphNormalAttributes))
        
        secondLabel!.attributedText = attributedString
        secondLabel!.numberOfLines = 0
        secondLabel!.textAlignment = .center
    }
    

    private func setupTopCircle(){
        let spaceHolder = UIView()
        spaceHolder.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(spaceHolder)
        NSLayoutConstraint.activate([
            spaceHolder.topAnchor.constraint(equalTo: imageView.topAnchor),
            spaceHolder.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.5),
            spaceHolder.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            spaceHolder.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.05)
        ])
        
        let topCircle = UIView()
        imageView.addSubview(topCircle)
        topCircle.translatesAutoresizingMaskIntoConstraints = false
        topCircle.layer.borderWidth = 3
        topCircle.layer.borderColor = UIColor.orange.cgColor
        topCircle.layer.cornerRadius = 20
        NSLayoutConstraint.activate([
            topCircle.topAnchor.constraint(equalTo: spaceHolder.bottomAnchor),
            topCircle.leadingAnchor.constraint(equalTo: spaceHolder.trailingAnchor),
            topCircle.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.6),
            topCircle.heightAnchor.constraint(equalTo: topCircle.widthAnchor, multiplier: 0.5)
        ])

    }
}

extension Onboarding4ViewController{
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
            return NSLocalizedString("Onboarding4_" + self.rawValue, tableName: "Texts", bundle: .main, value: ErrorHandler.localizedStringNotFound, comment: "Loc String")
        }
    }
}
