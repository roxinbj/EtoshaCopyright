//
//  MammalFactsViewController.swift
//  Etoscha
//
//  Created by Björn Roxin on 15.06.21.
//

import UIKit

class MammalFactsViewController: UIViewController{
    
    //MARK: Constants
    private var buttonHeight : CGFloat {
        let maxString = funFacts.max() ?? ""
        let height = NSAttributedString(string: maxString, attributes: Appearance.paragraphAttributes).height(withConstrainedWidth: self.view.frame.width)
        return min(height, self.view.frame.width/8)
    }
    private let arrowMargin : CGFloat = 0.13
    
    //MARK: Views
    private var headingViews = [UILabel]()
    private var textViews = [UILabel]()
    
    private let funFactHeading = UILabel()
    private let funFactView = UIView()
    private let funFactLeftArrowView = UIImageView()
    private let funFactRightArrowView = UIImageView()
    private let funFactTextView = UILabel()
    
    //MARK: Data
    var mammalType : MammalType?
    var funFactIndex = 0 {
        didSet {
            let rightestIndexValue = funFacts.count - 1
            if funFacts.count != 0 {
                // Reached left boundary -> choose rightest image
                if funFactIndex < 0 {
                    funFactIndex = rightestIndexValue
                    // Reached right boundary --> choose first image
                }else if funFactIndex > rightestIndexValue {
                    funFactIndex = 0
                }
            }
        }
    }
    private var headings = [String]()
    private var texts = [String]()
    private var funFacts = [String]()
    
    //MARK: Load View
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Appearance.backgroundColor
        loadData()
        setupFunFactHeading()
        setupFunFactView()
        setFunFactText()
        
        if headingViews.count > 0{
            setupFirstView()
            setupFirstTextView()
        }
        if headingViews.count > 1{
            setupSecondView()
            setupSecondTextView()
        }
        if headingViews.count > 2{
            setupThirdView()
            setupThirdTextView()
        }
        NSLayoutConstraint.activate([
            textViews.last!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -Appearance.spacing)
        ])
    }
    
    //MARK: Action
    @objc private func switchButton(sender : UITapGestureRecognizer){
        if sender.view?.tag == 1 {
            funFactIndex += 1
        }else {
            funFactIndex -= 1
        }
        setFunFactText()
    }

    
    //MARK: Setup Functions
    private func loadData(){
        funFacts = mammalType?.funFacts ?? []
        
        if mammalType?.etoshaFact != nil {
            headings.append(MyString.etoshaHeading.locString!)
            headingViews.append(UILabel())
            texts.append(mammalType!.etoshaFact!)
            textViews.append(UILabel())
        }
        if mammalType?.firstExtraFact != nil {
            headings.append(mammalType!.firstExtraFactHeading!)
            headingViews.append(UILabel())
            texts.append(mammalType!.firstExtraFact!)
            textViews.append(UILabel())
        }
        if mammalType?.conservationStatus != nil {
            headings.append(MyString.conservationHeading.locString!)
            headingViews.append(UILabel())
            texts.append(mammalType!.conservationStatus!)
            textViews.append(UILabel())
        }
    }
    
    private func setFunFactText(){
        funFactTextView.attributedText = NSAttributedString(string: funFacts[funFactIndex], attributes: Appearance.paragraphAttributes)
        funFactTextView.numberOfLines = 0
        funFactTextView.lineBreakMode = .byWordWrapping
        funFactTextView.textAlignment = .justified
    }
    
    private func setupFunFactHeading(){
        funFactHeading.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(funFactHeading)
        NSLayoutConstraint.activate([
            funFactHeading.topAnchor.constraint(equalTo: self.view.topAnchor,constant: Appearance.spacing),
            funFactHeading.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding),
            funFactHeading.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Appearance.padding)
        ])
        funFactHeading.textAlignment = .left
        funFactHeading.attributedText = NSAttributedString(string: MyString.funFactHeading.locString ?? "", attributes: Appearance.subheadingAttributes)
    }
    private func setupFunFactView(){
        funFactView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(funFactView)
        NSLayoutConstraint.activate([
            funFactView.topAnchor.constraint(equalTo: funFactHeading.bottomAnchor,constant: Appearance.spacing),
            funFactView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding/2),
            funFactView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Appearance.padding/2),
            funFactView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            funFactView.heightAnchor.constraint(greaterThanOrEqualTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1)
            //funFactView.heightAnchor.constraint(equalToConstant: buttonHeight*3)
        ])
        
        // Add Arrow Views
        funFactLeftArrowView.translatesAutoresizingMaskIntoConstraints = false
        funFactRightArrowView.translatesAutoresizingMaskIntoConstraints = false
        funFactView.addSubview(funFactLeftArrowView)
        funFactView.addSubview(funFactRightArrowView)
        NSLayoutConstraint.activate([
            funFactLeftArrowView.topAnchor.constraint(equalTo: funFactView.topAnchor),
            funFactLeftArrowView.leadingAnchor.constraint(equalTo: funFactView.leadingAnchor),
            funFactLeftArrowView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: arrowMargin),
            funFactLeftArrowView.bottomAnchor.constraint(equalTo: funFactView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            funFactRightArrowView.topAnchor.constraint(equalTo: funFactView.topAnchor),
            funFactRightArrowView.trailingAnchor.constraint(equalTo: funFactView.trailingAnchor),
            funFactRightArrowView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: arrowMargin),
            funFactRightArrowView.bottomAnchor.constraint(equalTo: funFactView.bottomAnchor)
        ])
        funFactRightArrowView.tag = 1
        let leftTapGesture = UITapGestureRecognizer(target: self, action: #selector(switchButton(sender:)))
        leftTapGesture.numberOfTouchesRequired = 1
        leftTapGesture.numberOfTapsRequired = 1
        funFactLeftArrowView.addGestureRecognizer(leftTapGesture)
        funFactLeftArrowView.isUserInteractionEnabled = true
        let rightTapGesture = UITapGestureRecognizer(target: self, action: #selector(switchButton(sender:)))
        rightTapGesture.numberOfTouchesRequired = 1
        rightTapGesture.numberOfTapsRequired = 1
        funFactRightArrowView.addGestureRecognizer(rightTapGesture)
        funFactRightArrowView.isUserInteractionEnabled = true
        funFactView.isUserInteractionEnabled = true
        
        // Add Text View
        funFactTextView.translatesAutoresizingMaskIntoConstraints = false
        funFactView.addSubview(funFactTextView)
        NSLayoutConstraint.activate([
            funFactTextView.topAnchor.constraint(equalTo: funFactView.topAnchor),
            funFactTextView.leadingAnchor.constraint(equalTo: funFactLeftArrowView.trailingAnchor),
            funFactTextView.trailingAnchor.constraint(equalTo: funFactRightArrowView.leadingAnchor),
            funFactTextView.bottomAnchor.constraint(equalTo: funFactView.bottomAnchor)
        ])
        
        funFactLeftArrowView.image = UIImage(named: "angle-left-solid")?.withTintColor(Appearance.primaryColor)
        funFactRightArrowView.image = UIImage(named: "angle-right-solid")?.withTintColor(Appearance.primaryColor)
        funFactLeftArrowView.contentMode = .scaleAspectFit
        funFactRightArrowView.contentMode = .scaleAspectFit
        funFactTextView.numberOfLines = 0
        funFactTextView.textAlignment = .justified
    }
    

    private func setupFirstView(){
        headingViews[0].translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(headingViews[0])
        NSLayoutConstraint.activate([
            headingViews[0].topAnchor.constraint(equalTo: funFactView.bottomAnchor,constant: Appearance.spacing),
            headingViews[0].leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding),
            headingViews[0].trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Appearance.padding)
        ])
        headingViews[0].attributedText = NSAttributedString(string: headings[0], attributes: Appearance.subheadingAttributes)
        headingViews[0].numberOfLines = 0
        headingViews[0].textAlignment = .left
    }
    
    private func setupFirstTextView(){
        textViews[0].translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textViews[0])
        NSLayoutConstraint.activate([
            textViews[0].topAnchor.constraint(equalTo: headingViews[0].bottomAnchor,constant: Appearance.spacing),
            textViews[0].leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding),
            textViews[0].trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Appearance.padding)
        ])
        textViews[0].attributedText = NSAttributedString(string: texts[0], attributes: Appearance.paragraphAttributes)
        textViews[0].numberOfLines = 0
        textViews[0].textAlignment = .justified
    }
    private func setupSecondView(){
        headingViews[1].translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(headingViews[1])
        NSLayoutConstraint.activate([
            headingViews[1].topAnchor.constraint(equalTo: textViews[0].bottomAnchor,constant: Appearance.spacing),
            headingViews[1].leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding),
            headingViews[1].trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Appearance.padding)
        ])
        headingViews[1].attributedText = NSAttributedString(string: headings[1], attributes: Appearance.subheadingAttributes)
        headingViews[1].numberOfLines = 0
        headingViews[1].textAlignment = .left

    }
    
    private func setupSecondTextView(){
        textViews[1].translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textViews[1])
        NSLayoutConstraint.activate([
            textViews[1].topAnchor.constraint(equalTo: headingViews[1].bottomAnchor,constant: Appearance.spacing),
            textViews[1].leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding),
            textViews[1].trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Appearance.padding)
        ])
        textViews[1].attributedText = NSAttributedString(string: texts[1], attributes: Appearance.paragraphAttributes)
        textViews[1].numberOfLines = 0
        textViews[1].textAlignment = .justified
    }
    private func setupThirdView(){
        headingViews[2].translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(headingViews[2])
        NSLayoutConstraint.activate([
            headingViews[2].topAnchor.constraint(equalTo: textViews[1].bottomAnchor,constant: Appearance.spacing),
            headingViews[2].leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding),
            headingViews[2].trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Appearance.padding)
        ])
        headingViews[2].attributedText = NSAttributedString(string: headings[2], attributes: Appearance.subheadingAttributes)
        headingViews[2].numberOfLines = 0
        headingViews[2].textAlignment = .left
    }
    
    private func setupThirdTextView(){
        textViews[2].translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textViews[2])
        NSLayoutConstraint.activate([
            textViews[2].topAnchor.constraint(equalTo: headingViews[2].bottomAnchor,constant: Appearance.spacing),
            textViews[2].leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding),
            textViews[2].trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Appearance.padding)
        ])
        textViews[2].attributedText = NSAttributedString(string: texts[2], attributes: Appearance.paragraphAttributes)
        textViews[2].numberOfLines = 0
        textViews[2].textAlignment = .justified
    }
}

extension MammalFactsViewController{
    //MARK: Localized Stings
    enum MyString:String {
        case additionalHeading = "_additionalFactHeading"
        case etoshaHeading = "_etoshaSpecificHeading"
        case conservationHeading = "_conservationHeading"
        case funFactHeading = "_funFactHeading"
        
//        case firstHeading = "_etoshaSpecificHeading"
//        case secondHeading = "_First"
//        case thirdHeading = "_Sec"
        
        
        var locString : String?{
            let localString = getLocalizedString(for: self.rawValue, viewType: EtoshaViews.mammalsFactsView)
            if localString == ErrorHandler.localizedStringNotFound{
                return nil
            }
            return localString
        }
    }
}

