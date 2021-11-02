//
//  MammalHabitatViewController.swift
//  Etoscha
//
//  Created by Björn Roxin on 15.06.21.
//

import UIKit

class MammalHabitatViewController: UIViewController {
    //MARK: Constants
    private var habitatImageRatio : CGFloat = 0.4
    
    //MARK: Views
    private var namibianHabitatHeading = UILabel()
    private var habitatImageView = UIImageView()

    private var horizontalLine = UIView()
    private var iconHeading = UILabel()
    private var habitatIconsStack = UIStackView()
    
    //MARK: Data
    var mammalType : MammalType? {
        didSet{
            guard mammalType != nil else { return }
            habitatCollection = mammalType!.habitat
            habitatImageView.image = getMapImage()
            namibianHabitatHeading.attributedText = NSAttributedString(string: MyString.habitatHeading.locString, attributes: Appearance.subheadingAttributes)
           
        }
    }
    private var habitatCollection = [Habitat]() {
        didSet{
            habitatIconsStack = UIStackView()
            fillIconStack()
        }
    }
    
    //MARK: Load View
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Appearance.backgroundColor
        setupHabitatMapHeading()
        setupHabitatMapImageView()
        setupLorizontalLine(for: horizontalLine, topAnchor: habitatImageView, mainView: self.view, parentView: self.view)
        setupHeading(for: iconHeading, topAnchor: horizontalLine, with: MyString.iconHeading.locString, mainView: self.view, parentView: self.view)
        setupHabitatIconStackView()
        NSLayoutConstraint.activate([
            habitatIconsStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -Appearance.spacing)
        ])
    }
    
    private func fillIconStack(){
        let aspectRatio = CGFloat(0.3)
        let columns = 2
        let rows = habitatCollection.count / columns + habitatCollection.count % columns
        
        var index = 0
        for _ in 0..<rows {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = Appearance.spacing/2
            rowStack.distribution = .fillEqually
            for _ in 0..<columns{
                if index < habitatCollection.count{
                    let card = IconWithNameView()
                    card.widthAnchor.constraint(equalTo: card.heightAnchor, multiplier: 1/aspectRatio).isActive = true
                    card.configure(withImageName: habitatCollection[index].image, title: habitatCollection[index].name)
                    index += 1
                    rowStack.addArrangedSubview(card)
                }
                else {
                    rowStack.addArrangedSubview(UIView())
                }
            }
            habitatIconsStack.addArrangedSubview(rowStack)
        }
    }
}

extension MammalHabitatViewController{
    //MARK: Setup Functions
    private func setupHabitatMapHeading() {
        namibianHabitatHeading.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(namibianHabitatHeading)
        NSLayoutConstraint.activate([
            namibianHabitatHeading.topAnchor.constraint(equalTo: self.view.topAnchor,constant: Appearance.spacing),
            namibianHabitatHeading.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding),
            namibianHabitatHeading.widthAnchor.constraint(equalTo: self.view.widthAnchor),
        ])
        namibianHabitatHeading.textAlignment = .left
    }
    
    private func setupHabitatMapImageView(){
        habitatImageView.translatesAutoresizingMaskIntoConstraints = false
        habitatImageView.contentMode = .scaleAspectFit
        habitatImageView.sizeToFit()
        habitatImageView.clipsToBounds = true
        self.view.addSubview(habitatImageView)
        NSLayoutConstraint.activate([
            habitatImageView.topAnchor.constraint(equalTo: namibianHabitatHeading.bottomAnchor, constant: Appearance.spacing),
            habitatImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            habitatImageView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: habitatImageRatio)
        ])
    }
    private func setupHabitatIconStackView(){
        habitatIconsStack.translatesAutoresizingMaskIntoConstraints = false
        habitatIconsStack.alignment = .fill
        habitatIconsStack.distribution = .equalSpacing
        habitatIconsStack.axis = .vertical
        self.view.addSubview(habitatIconsStack)
        NSLayoutConstraint.activate([
            habitatIconsStack.topAnchor.constraint(equalTo: iconHeading.bottomAnchor, constant: Appearance.spacing),
            habitatIconsStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Appearance.padding),
            habitatIconsStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Appearance.padding)
        ])
    }
}

extension MammalHabitatViewController {
    //MARK: Localized Strings
    
    enum MyString: String {
        case iconHeading = "_iconHeading"
        case habitatHeading = "_habitatHeading"
        
        var locString : String {
            getLocalizedString(for: self.rawValue, viewType: EtoshaViews.mammalsHabitatView)
        }
    }

    //MARK: Paths
    private func getMapImage()-> UIImage? {
        if mammalType! == .blackRhino || mammalType! == .whiteRhino{
            habitatImageRatio = 0.3
            return UIImage(named: "SaveRhino")
        }
        if mammalType! == .groundPangolin{
            habitatImageRatio = 0.2
            return UIImage(named: "SavePandolin")
        }
        return UIImage(named: mammalType!.rawValue + "/Icons/" + mammalType!.rawValue + "Map")?.withRenderingMode(.automatic).withTintColor(Appearance.primaryColor)
    }
}
