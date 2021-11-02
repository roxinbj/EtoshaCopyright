//
//  MammalAppearanceViewController.swift
//  Etoscha
//
//  Created by Björn Roxin on 15.06.21.
//

import UIKit

class MammalAppearanceViewController: UIViewController {
    
    //MARK: Constants
    private let genderImageWidthRatio : CGFloat = 0.55
    
    //MARK: Views
    private let appearanceDescription = UILabel()
    private let horizontalLine = UIView()
    private var maleImageView = UIImageView()
    private var maleCaption = UILabel()
    private var femaleImageView = UIImageView()
    private var femaleCaption = UILabel()
    private let genderDiffHeading = UILabel()
    private let genderDiffDescription = UILabel()

    //MARK: Data
    private var genderDiffTopConstraint = NSLayoutConstraint()

    var mammalType : MammalType? {
        didSet{
            guard mammalType != nil else { return }
            appearanceDescription.attributedText = NSAttributedString(string: mammalType!.appearance ?? "", attributes: Appearance.paragraphAttributes)
            appearanceDescription.numberOfLines = 0
            appearanceDescription.textAlignment = .justified
            
            maleImageView.image = getMaleImage()
            
            femaleImageView.image = getFemaleImage()
            setFemaleImage(as: femaleImageView.image != nil)
            
            genderDiffHeading.attributedText = NSAttributedString(string: getGenderDiffHeading(), attributes: Appearance.subheadingAttributes)
            genderDiffDescription.attributedText = NSAttributedString(string: mammalType!.genderDiff ?? "", attributes: Appearance.paragraphAttributes)
            genderDiffDescription.numberOfLines = 0
            genderDiffDescription.textAlignment = .justified
        }
    }
    
    //MARK: Load View
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Appearance.backgroundColor
        setupAppearanceDescription()
        setupLorizontalLine(for: horizontalLine, topAnchor: appearanceDescription, mainView: self.view, parentView: self.view)
        setupGenderDiffHeading()
        setupMaleImageView()
        setupMaleCaption()
        setupFemaleImageView()
        setupFemaleCaption()
        setupGenderDiffDescription()
        NSLayoutConstraint.activate([
            genderDiffDescription.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -Appearance.spacing)
        ])
    }
}

extension MammalAppearanceViewController{
    //MARK: Setup Functions
    private func setupAppearanceDescription(){
        appearanceDescription.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(appearanceDescription)
        NSLayoutConstraint.activate([
            appearanceDescription.topAnchor.constraint(equalTo: self.view.topAnchor,constant: Appearance.spacing),
            appearanceDescription.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding),
            appearanceDescription.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Appearance.padding)
        ])
        appearanceDescription.numberOfLines = 0
        appearanceDescription.textAlignment = .justified
    }
    
    private func setupGenderDiffHeading() {
        genderDiffHeading.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(genderDiffHeading)
        NSLayoutConstraint.activate([
            genderDiffHeading.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor,constant: Appearance.spacing),
            genderDiffHeading.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding),
            genderDiffHeading.widthAnchor.constraint(equalTo: self.view.widthAnchor),
        ])
        genderDiffHeading.textAlignment = .left
    }
    private func setupMaleImageView(){
        maleImageView.translatesAutoresizingMaskIntoConstraints = false
        maleImageView.contentMode = .scaleAspectFit
        maleImageView.sizeToFit()
        maleImageView.clipsToBounds = true
        self.view.addSubview(maleImageView)
        NSLayoutConstraint.activate([
            //maleImageView.topAnchor.constraint(equalTo: genderDiffHeading.bottomAnchor, constant: Appearance.spacing),
            //maleImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            //maleImageView.widthAnchor.constraint(lessThanOrEqualTo: self.view.widthAnchor, multiplier: 0.7),
            //maleImageView.heightAnchor.constraint(lessThanOrEqualTo: self.view.widthAnchor, multiplier: genderImageWidthRatio)
            maleImageView.topAnchor.constraint(equalTo: genderDiffHeading.bottomAnchor, constant: Appearance.spacing),
            maleImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            maleImageView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: genderImageWidthRatio),
            maleImageView.widthAnchor.constraint(lessThanOrEqualTo: self.view.widthAnchor, multiplier: 0.9)
        ])
    }
    
    private func setupMaleCaption(){
        maleCaption.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(maleCaption)
        NSLayoutConstraint.activate([
            maleCaption.topAnchor.constraint(equalTo: maleImageView.bottomAnchor,constant: Appearance.spacing/2),
            maleCaption.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Appearance.padding*5),
            maleCaption.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Appearance.padding*5),
        ])
        maleCaption.numberOfLines = 0
        maleCaption.textAlignment = .left
        maleCaption.attributedText = NSAttributedString(string: getMaleCaption(), attributes: Appearance.paragraphAttributes)
    }
    
    private func setFemaleImage(as shown: Bool){
        if shown {
            // Show female image and set gender specific caption
            genderDiffTopConstraint = genderDiffDescription.topAnchor.constraint(equalTo: femaleCaption.bottomAnchor,constant: Appearance.spacing)
            femaleCaption.isHidden = false
            femaleImageView.isHidden = false
        }else {
            // Hide Female Image and Male Caption
            genderDiffTopConstraint = genderDiffDescription.topAnchor.constraint(equalTo: maleCaption.bottomAnchor,constant: Appearance.spacing)
            femaleCaption.isHidden = true
            femaleImageView.isHidden = true
            maleCaption.isHidden = true
        }
    }
    
    private func setupFemaleImageView(){
        femaleImageView.translatesAutoresizingMaskIntoConstraints = false
        femaleImageView.contentMode = .scaleAspectFit
        femaleImageView.sizeToFit()
        femaleImageView.clipsToBounds = true
        self.view.addSubview(femaleImageView)
        femaleImageView.topAnchor.constraint(equalTo: maleCaption.bottomAnchor, constant: Appearance.spacing).isActive = true
        femaleImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        femaleImageView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: genderImageWidthRatio).isActive = true
        femaleImageView.widthAnchor.constraint(lessThanOrEqualTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
    }
    
    private func setupFemaleCaption(){
        femaleCaption.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(femaleCaption)
        NSLayoutConstraint.activate([
            femaleCaption.topAnchor.constraint(equalTo: femaleImageView.bottomAnchor,constant: Appearance.spacing/2),
            femaleCaption.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Appearance.padding*5),
            femaleCaption.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Appearance.padding*5),
        ])
        femaleCaption.numberOfLines = 0
        femaleCaption.textAlignment = .left
        femaleCaption.attributedText = NSAttributedString(string: getFemaleCaption(), attributes: Appearance.paragraphAttributes)
    }
    
    private func setupGenderDiffDescription(){
        genderDiffDescription.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(genderDiffDescription)
        
        NSLayoutConstraint.activate([
            genderDiffTopConstraint,
            genderDiffDescription.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding),
            genderDiffDescription.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Appearance.padding)
        ])
        genderDiffDescription.numberOfLines = 0
        genderDiffDescription.textAlignment = .justified
    }
}

extension MammalAppearanceViewController{
    //MARK: Localized Stings
    private func getGenderDiffHeading()->String {
        return NSLocalizedString(EtoshaViews.mammalsAppearanceView.rawValue+"_genderDiffHeading", tableName: "Texts", bundle: .main, value: "No text found", comment: "")
    }
    private func getFemaleCaption()->String {
        return NSLocalizedString(EtoshaViews.mammalsAppearanceView.rawValue+"_female", tableName: "Texts", bundle: .main, value: "No text found", comment: "")
    }
    private func getMaleCaption()->String {
        return NSLocalizedString(EtoshaViews.mammalsAppearanceView.rawValue+"_male", tableName: "Texts", bundle: .main, value: "No text found", comment: "")
    }
    private func getMaleImage() -> UIImage?{
        var maleImage = UIImage(named: mammalType!.rawValue + "/Photos/" + mammalType!.rawValue + "Male")
        if maleImage == nil {
            maleImage = UIImage(named: (mammalType!.rawValue + "/Photos/" + mammalType!.rawValue + "Trans01"))
        }
        return maleImage
    }
    private func getFemaleImage() -> UIImage?{
        return UIImage(named: mammalType!.rawValue + "/Photos/" + mammalType!.rawValue + "Female")
    }
    
}
