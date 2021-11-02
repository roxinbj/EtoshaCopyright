//
//  MammalDietViewController.swift
//  Etoscha
//
//  Created by Björn Roxin on 15.06.21.
//

import UIKit

class MammalDietViewController: UIViewController {
    //MARK: Constants
    private let spacing : CGFloat = 20
    private let padding : CGFloat = 20
    
    //MARK: Views
    private var dietIconsStack = UIStackView()
    private let dietDescription = UILabel()
    private let horizontalLine = UIView()
    private let predatorHeading = UILabel()
    private let predatorsDescription = UILabel()
    
    
    //MARK: Data
    var mammalType : MammalType? {
        didSet{
            guard mammalType != nil else { return }
            dietDescription.attributedText = NSAttributedString(string: mammalType!.dietText ?? "", attributes: Appearance.paragraphAttributes)
            dietDescription.numberOfLines = 0
            dietDescription.textAlignment = .justified
            dietCollection = mammalType!.diet
            predatorHeading.attributedText = NSAttributedString(string: MyStrings.predatorHeading.locString , attributes: Appearance.subheadingAttributes)
            predatorsDescription.attributedText = NSAttributedString(string: mammalType!.predators ?? "", attributes: Appearance.paragraphAttributes)
            predatorsDescription.numberOfLines = 0
            predatorsDescription.textAlignment = .justified
        }
    }
    
    private var dietCollection = [Diet]() {
        didSet{
            dietIconsStack = UIStackView()
            fillIconStack()
        }
    }
    
    //MARK: Load View
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Appearance.backgroundColor
        setupDietIconStackView()
        setupDietDescription()
        setupLorizontalLine(for: horizontalLine, topAnchor: dietDescription, mainView: self.view, parentView: self.view)
        setupPredatorViews()
        NSLayoutConstraint.activate([
            predatorsDescription.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -Appearance.spacing)
        ])
    }
    
    private func fillIconStack(){
        let aspectRatio = CGFloat(0.3)
        let columns = 2
        let rows = dietCollection.count / columns + dietCollection.count % columns
        
        var index = 0
        for _ in 0..<rows {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 10
            rowStack.distribution = .fillEqually
            for _ in 0..<columns{
                if index < dietCollection.count{
                    let card = IconWithNameView()
                    card.widthAnchor.constraint(equalTo: card.heightAnchor, multiplier: 1/aspectRatio).isActive = true
                    card.configure(withImageName: dietCollection[index].image, title: dietCollection[index].name)
                    index += 1
                    rowStack.addArrangedSubview(card)
                }
                else {
                    rowStack.addArrangedSubview(UIView())
                }
            }
            dietIconsStack.addArrangedSubview(rowStack)
        }
    }
}

extension MammalDietViewController{
    //MARK: Setup Functions
    private func setupDietIconStackView(){
        dietIconsStack.translatesAutoresizingMaskIntoConstraints = false
        dietIconsStack.alignment = .fill
        dietIconsStack.distribution = .equalSpacing
        dietIconsStack.axis = .vertical
        self.view.addSubview(dietIconsStack)
        NSLayoutConstraint.activate([
            dietIconsStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: spacing),
            dietIconsStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding),
            dietIconsStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding)
        ])
        
    }
    
    private func setupDietDescription(){
        dietDescription.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(dietDescription)
        NSLayoutConstraint.activate([
            dietDescription.topAnchor.constraint(equalTo: dietIconsStack.bottomAnchor,constant: spacing),
            dietDescription.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            dietDescription.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -padding)
        ])
        dietDescription.numberOfLines = 0
        dietDescription.textAlignment = .justified
    }
    
    private func setupPredatorViews() {
        predatorHeading.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(predatorHeading)
        NSLayoutConstraint.activate([
            predatorHeading.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor,constant: spacing),
            predatorHeading.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            predatorHeading.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Appearance.padding),
        ])
        predatorHeading.textAlignment = .left
        
        predatorsDescription.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(predatorsDescription)
        NSLayoutConstraint.activate([
            predatorsDescription.topAnchor.constraint(equalTo: predatorHeading.bottomAnchor,constant: spacing),
            predatorsDescription.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            predatorsDescription.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -padding)
        ])
        predatorsDescription.numberOfLines = 0
        predatorsDescription.textAlignment = .justified
    }
}

extension MammalDietViewController{
    enum MyStrings:String{
        case predatorHeading = "_predatorHeading"
        var locString : String {
            getLocalizedString(for: self.rawValue, viewType: EtoshaViews.mammalDietView)
        }
    }
}
