//
//  Onboarding1ViewController.swift
//  Pods
//
//  Created by Björn Roxin on 14.08.21.
//

import UIKit

class Onboarding1ViewController: OnboardingBaseViewController {
    
    //MARK: Views
    private var subheadingView : UILabel?
    private var firstLabel : UILabel?
    private var secondLabel : UILabel?
    private var thirdLabel : UILabel?
    
    override func loadView() {
        super.loadView()
        solidDotIndex = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let heading = NSMutableAttributedString(string: MyStrings.titleBold.locString, attributes: headingBoldAttributes)
        heading.append(NSMutableAttributedString(string: MyStrings.titleNormal.locString, attributes: headingNormalAttributes))
        setTitle(with: heading)
        setImage(with: "Onboarding/HomeScreen")
        setupFirstLabel()
        setupSecondLabel()
        setupThirdLabel()
        // Do any additional setup after loading the view.
    }
    
    
    override func touchNextButton(){
        let vc = Onboarding2ViewController()
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
        spaceHolder.isHidden = true
        
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
        firstLabel!.lineBreakMode = .byClipping
    }
    
    private func setupSecondLabel(){
        let spaceHolder = UIView()
        spaceHolder.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(spaceHolder)
        NSLayoutConstraint.activate([
            spaceHolder.topAnchor.constraint(equalTo: firstLabel!.bottomAnchor),
            spaceHolder.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.11),
            spaceHolder.leadingAnchor.constraint(equalTo: imageView.trailingAnchor),
            spaceHolder.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        spaceHolder.isHidden = true
        
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
        secondLabel!.lineBreakMode = .byClipping
        secondLabel!.sizeToFit()
    }
    private func setupThirdLabel(){
        let spaceHolder = UIView()
        spaceHolder.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(spaceHolder)
        NSLayoutConstraint.activate([
            spaceHolder.topAnchor.constraint(equalTo: secondLabel!.bottomAnchor, constant: -10),
            spaceHolder.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.10),
            spaceHolder.leadingAnchor.constraint(equalTo: imageView.trailingAnchor),
            spaceHolder.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        spaceHolder.isHidden = true
        
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
        thirdLabel!.lineBreakMode = .byClipping
        thirdLabel!.sizeToFit()
    }
    

}

extension Onboarding1ViewController{
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
            return NSLocalizedString("Onboarding1_" + self.rawValue, tableName: "Texts", bundle: .main, value: ErrorHandler.localizedStringNotFound, comment: "Loc String")
        }
    }
}
