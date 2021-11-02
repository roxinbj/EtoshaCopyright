//
//  MammalSizeViewController.swift
//  Etoscha
//
//  Created by Björn Roxin on 15.06.21.
//

import UIKit

class MammalSizeViewController: UIViewController {
    //MARK: Constants
    let spacing : CGFloat = 20
    let padding : CGFloat = 20
    let sizeWidthRatio : CGFloat = 0.4
    let footprintWidthRatio : CGFloat = 0.4
    
    //MARK: Views
    private var footprintImageView = UIImageView()
    private let footprintHeading = UILabel()
    private var sizeComparisonImageView = UIImageView()
    private let sizeComparisonHeading = UILabel()
    private let sizeComparisonDescription = UILabel()
    
    //MARK: Data
    var mammalType : MammalType? {
        didSet{
            guard mammalType != nil else { return }
            footprintHeading.attributedText = NSAttributedString(string: MyStrings.footprintText.locString, attributes: Appearance.subheadingAttributes)
            footprintHeading.numberOfLines = 0
            footprintHeading.textAlignment = .justified
            footprintImageView.image = UIImage(named: getFootprintImagePath())?.withRenderingMode(.automatic).withTintColor(Appearance.primaryColor)
            
            sizeComparisonHeading.attributedText = NSAttributedString(string: MyStrings.sizeText.locString, attributes: Appearance.subheadingAttributes)
            sizeComparisonHeading.textAlignment = .left
            sizeComparisonImageView.image = UIImage(named: getSizeImagePath())?.withRenderingMode(.automatic).withTintColor(Appearance.primaryColor)
            sizeComparisonDescription.attributedText = NSAttributedString(string: mammalType!.sizeDescription ?? "", attributes: Appearance.paragraphAttributes)
            sizeComparisonDescription.numberOfLines = 0
            sizeComparisonDescription.textAlignment = .justified
        }
    }
    
    //MARK: Load View
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Appearance.backgroundColor
        setupFootprintHeading()
        setupFootprintImageView()
        setupSizeComparisonHeading()
        setupSizeComparisonImageView()
        NSLayoutConstraint.activate([
            sizeComparisonImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -Appearance.spacing)
        ])
    }
}

extension MammalSizeViewController{
    //MARK: View Setup Functions
    private func setupFootprintHeading(){
        footprintHeading.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(footprintHeading)
        NSLayoutConstraint.activate([
            footprintHeading.topAnchor.constraint(equalTo: self.view.topAnchor,constant: spacing),
            footprintHeading.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            footprintHeading.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -padding)
        ])
        footprintHeading.numberOfLines = 0
        footprintHeading.textAlignment = .justified
    }
    private func setupFootprintImageView(){
        footprintImageView.translatesAutoresizingMaskIntoConstraints = false
        footprintImageView.contentMode = .scaleAspectFit
        footprintImageView.sizeToFit()
        footprintImageView.clipsToBounds = true
        self.view.addSubview(footprintImageView)
        NSLayoutConstraint.activate([
            footprintImageView.topAnchor.constraint(equalTo: footprintHeading.bottomAnchor, constant: spacing),
            footprintImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            footprintImageView.heightAnchor.constraint(lessThanOrEqualTo: self.view.widthAnchor, multiplier: footprintWidthRatio)
        ])
    }
    
    private func setupSizeComparisonHeading() {
        sizeComparisonHeading.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(sizeComparisonHeading)
        NSLayoutConstraint.activate([
            sizeComparisonHeading.topAnchor.constraint(equalTo: footprintImageView.bottomAnchor,constant: spacing),
            sizeComparisonHeading.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            sizeComparisonHeading.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),

            //sizeComparisonHeading.widthAnchor.constraint(equalTo: self.view.widthAnchor),
        ])
        sizeComparisonHeading.textAlignment = .left
    }
    
    private func setupSizeComparisonImageView(){
        sizeComparisonImageView.translatesAutoresizingMaskIntoConstraints = false
        sizeComparisonImageView.contentMode = .scaleAspectFit
        sizeComparisonImageView.sizeToFit()
        sizeComparisonImageView.clipsToBounds = true
        self.view.addSubview(sizeComparisonImageView)
        NSLayoutConstraint.activate([
            sizeComparisonImageView.topAnchor.constraint(equalTo: sizeComparisonHeading.bottomAnchor, constant: spacing),
            sizeComparisonImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            sizeComparisonImageView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: sizeWidthRatio)
        ])
    }
    
    private func setupSizeComparisonText(){
        sizeComparisonDescription.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(sizeComparisonDescription)
        NSLayoutConstraint.activate([
            sizeComparisonDescription.topAnchor.constraint(equalTo: sizeComparisonImageView.bottomAnchor,constant: spacing),
            sizeComparisonDescription.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            sizeComparisonDescription.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -padding)
        ])
        sizeComparisonDescription.numberOfLines = 0
        sizeComparisonDescription.textAlignment = .justified
    }
}


extension MammalSizeViewController{
    enum MyStrings:String {
        case title = "_heading"
        case footprintText = "_footprintHeading"
        case sizeText = "_sizeHeading"
        
        var locString : String {
            getLocalizedString(for: self.rawValue, viewType: EtoshaViews.mammalsSizeView)
        }
    }
    
    
    //MARK: Paths
    private func getFootprintImagePath() -> String{
        return mammalType!.rawValue + "/Icons/" + mammalType!.rawValue + "Print"
    }
    private func getSizeImagePath() -> String{
        return mammalType!.rawValue + "/Icons/" + mammalType!.rawValue + "Size"
    }
}
