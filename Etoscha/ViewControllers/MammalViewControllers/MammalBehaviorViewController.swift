//
//  MammalBehaviorViewController.swift
//  Etoscha
//
//  Created by Björn Roxin on 15.06.21.
//

import UIKit

class MammalBehaviorViewController: UIViewController {
    //MARK: Constants
    private let spacing : CGFloat = 20
    private let padding : CGFloat = 20
    private let socialImageWidthRatio : CGFloat = 0.4
   
    //MARK: Views
    private var socialityImageView = UIImageView()
    private let socialBehaviorDescription = UILabel()
    private let behaviorDescription = UILabel()
    private let horizontalLine = UIView()
    private let offspringHeading = UILabel()
    private let offspringDescription = UILabel()
    
    //MARK: Data
    var mammalType : MammalType? {
        didSet{
            guard mammalType != nil else { return }
            socialBehaviorDescription.attributedText = NSAttributedString(string: mammalType!.socialBehavior ?? "", attributes: Appearance.paragraphAttributes)
            socialBehaviorDescription.numberOfLines = 0
            socialBehaviorDescription.textAlignment = .justified
            behaviorDescription.attributedText = NSAttributedString(string: mammalType!.behavior ?? "", attributes: Appearance.paragraphAttributes)
            behaviorDescription.numberOfLines = 0
            behaviorDescription.textAlignment = .justified
            socialityImageView.image = UIImage(named: getSocialImagePath())?.withRenderingMode(.automatic).withTintColor(Appearance.primaryColor)
            offspringHeading.attributedText = NSAttributedString(string: getOffspringHeading(), attributes: Appearance.subheadingAttributes)
            offspringHeading.textAlignment = .left
            offspringDescription.attributedText = NSAttributedString(string: mammalType!.raisingCalves ?? "", attributes: Appearance.paragraphAttributes)
            offspringDescription.numberOfLines = 0
            offspringDescription.textAlignment = .justified
        }
    }
    
    //MARK: Load View
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Appearance.backgroundColor
        setupImageView()
        setupSocialBehaviorDescription()
        setupBehaviorDescription()
        setupHorizontalLine()
        setupOffspringViews()
        NSLayoutConstraint.activate([
            offspringDescription.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -Appearance.spacing)
        ])
    }
}

extension MammalBehaviorViewController {
    //MARK: Setup Functions
    private func setupImageView(){
        socialityImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(socialityImageView)
        NSLayoutConstraint.activate([
            socialityImageView.topAnchor.constraint(equalTo:  self.view.topAnchor, constant: Appearance.spacing),
            socialityImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            socialityImageView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4),
            socialityImageView.widthAnchor.constraint(lessThanOrEqualTo: self.view.widthAnchor, multiplier: 0.9)
        ])
        socialityImageView.contentMode = .scaleAspectFit
        socialityImageView.clipsToBounds = true
    }
    
    private func setupSocialBehaviorDescription(){
        socialBehaviorDescription.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(socialBehaviorDescription)
        NSLayoutConstraint.activate([
            socialBehaviorDescription.topAnchor.constraint(equalTo: socialityImageView.bottomAnchor,constant: Appearance.spacing/2),
            socialBehaviorDescription.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding),
            socialBehaviorDescription.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Appearance.padding)
        ])
        socialBehaviorDescription.numberOfLines = 0
        socialBehaviorDescription.textAlignment = .justified
    }
    
    private func setupBehaviorDescription(){
        behaviorDescription.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(behaviorDescription)
        NSLayoutConstraint.activate([
            behaviorDescription.topAnchor.constraint(equalTo: socialBehaviorDescription.bottomAnchor,constant: Appearance.spacing),
            behaviorDescription.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding),
            behaviorDescription.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Appearance.padding)
        ])
        behaviorDescription.numberOfLines = 0
        behaviorDescription.textAlignment = .justified
    }
    
    private func setupHorizontalLine(){
        horizontalLine.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(horizontalLine)
        horizontalLine.backgroundColor = Appearance.primaryColor
        NSLayoutConstraint.activate([
            horizontalLine.topAnchor.constraint(equalTo: behaviorDescription.bottomAnchor,constant: Appearance.spacing),
            horizontalLine.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            horizontalLine.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: Appearance.horizontalLineWidthRatio),
            horizontalLine.heightAnchor.constraint(equalToConstant: Appearance.horizontalLineWidth),
        ])
    }
    
    private func setupOffspringViews() {
        offspringHeading.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(offspringHeading)
        NSLayoutConstraint.activate([
            offspringHeading.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor,constant: Appearance.spacing),
            offspringHeading.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding),
            offspringHeading.widthAnchor.constraint(equalTo: self.view.widthAnchor),
        ])
        offspringHeading.textAlignment = .left
        
        offspringDescription.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(offspringDescription)
        NSLayoutConstraint.activate([
            offspringDescription.topAnchor.constraint(equalTo: offspringHeading.bottomAnchor,constant: Appearance.spacing),
            offspringDescription.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding),
            offspringDescription.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Appearance.padding)
        ])
        offspringDescription.numberOfLines = 0
        offspringDescription.textAlignment = .justified
    }
}

extension MammalBehaviorViewController{
    //MARK: Localized Stings
    private func getOffspringHeading()->String {
        return NSLocalizedString(EtoshaViews.mammalsBehaviorView.rawValue+"_offspringHeading", tableName: "Texts", bundle: .main, value: "No text found", comment: "")
    }
    //MARK: PAths
    private func getSocialImagePath()->String{
        return mammalType!.rawValue + "/Icons/" + mammalType!.rawValue + "Sociability"

    }
}
