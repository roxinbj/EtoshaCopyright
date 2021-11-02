//
//  AboutEtoshaViewController.swift
//  Etoscha
//
//  Created by Björn Roxin on 26.05.21.
//

import UIKit

class AboutEtoshaViewController: UIViewController {
    //MARK: Constants
    let imageMaxHeightRatio : CGFloat = 0.2
    
    private var scrollView = UIScrollView()
    
    //MARK: Views
    private var topImageView = UIImageView()
    private var topTextView = UILabel()
    private var horizontalLine = UIView()
    private var bottomImageView = UIImageView()
    private var bottomTextView = UILabel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Appearance.backgroundColor
        setupDefaultNavBar()
        addSingleTitleToNavBar(title: MyStrings.title.locString)
        setupScrollView(for: scrollView, parent: view)
        setupTopImage()
        setupParagraph(for: topTextView, topAnchor: topImageView, with: MyStrings.topText.locString, mainView: self.view, parentView: scrollView)
        setupLorizontalLine(for: horizontalLine, topAnchor: topTextView, mainView: self.view, parentView: scrollView)
        setupBottomImage()
        setupParagraph(for: bottomTextView, topAnchor: bottomImageView, with: MyStrings.bottomText.locString, mainView: self.view, parentView: scrollView)
        NSLayoutConstraint.activate([
            bottomTextView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Appearance.spacing)
        ])
    }
}

extension AboutEtoshaViewController{
    //MARK: Setup Functions
    private func setupTopImage(){
        topImageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: MyStrings.topImage.rawValue)
        if image == nil {
            print("\(MyStrings.topImage.rawValue) not found ")

        }
        topImageView.image = image
        topImageView.contentMode = .scaleAspectFill
        scrollView.addSubview(topImageView)
        NSLayoutConstraint.activate([
            topImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            topImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            topImageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            topImageView.heightAnchor.constraint(lessThanOrEqualToConstant: view.frame.height*0.3)
        ])
    }
    private func setupBottomImage(){
        bottomImageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: MyStrings.bottomImage.rawValue)
        if image == nil {
            print("\(MyStrings.bottomImage.rawValue) not found ")

        }
        bottomImageView.image = image
        bottomImageView.contentMode = .scaleAspectFill
        scrollView.addSubview(bottomImageView)
        NSLayoutConstraint.activate([
            bottomImageView.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor, constant: Appearance.spacing),
            bottomImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            bottomImageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            bottomImageView.heightAnchor.constraint(lessThanOrEqualToConstant: view.frame.height*0.3)
        ])
    }
}


extension AboutEtoshaViewController{
    enum MyStrings:String {
        case title  = "_heading"
        case button = "_button"
        case topText = "_topInfo"
        case bottomText = "_bottomInfo"
        
        case topImage = "NamutoniOld"
        case bottomImage = "EtoshaPan"
        
        var locString : String {
            getLocalizedString(for: self.rawValue, viewType: EtoshaViews.aboutEtoshaView)
        }
        
    }
}
