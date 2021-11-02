//
//  LeopardCheetahDiffViewController.swift
//  Etoscha
//
//  Created by Björn Roxin on 27.07.21.
//

import UIKit

class MammalComparisonViewController: UIViewController {
    //MARK: Constants
    private let spotSizeFactor : CGFloat = 0.05
    private let textCornerRadius : CGFloat = 5
    private let maxImageWidthRatio : CGFloat = 0.5
    private let maxImageHeightRatio : CGFloat = 0.15

    var widthScaleFactor : CGFloat = 1
    
    //MARK: Data
    var diffType : MammalDifference?{
        didSet{
            if diffType != nil{
                imageViews = [UIImageView]()
                descriptionViews = [UILabel]()
                headingViews = [UILabel]()
                horizontalLines = [UIView]()
                infoViews = [[UIView]]()
                spots = [[UIView]]()
                // One Vector for each animal
                for animal in diffType!.animals {
                    imageViews!.append(UIImageView())
                    descriptionViews!.append(UILabel())
                    headingViews!.append(UILabel())
                    horizontalLines!.append(UIView())
                    
                    // Fill vector with differences on animal
                    var animalSpots = [UIView]()
                    var animalLabels = [UIView]()
                    for _ in animal.differences!.indices {
                        animalSpots.append(UIView())
                        animalLabels.append(UIView())
                    }
                    spots!.append(animalSpots)
                    infoViews!.append(animalLabels)
                }
            }
        }
    }
        
    private var animals : [MammalType] {
        return diffType?.animals ?? []
    }
    
    //MARK: Views
    private var scrollview = UIScrollView()
    
    // Size equals animals.count
    private var imageViews : [UIImageView]?
    private var descriptionViews : [UILabel]?
    private var horizontalLines : [UIView]?
    private var headingViews : [UILabel]?
    private var infoViews : [[UIView]?]?
    private var spots : [[UIView]?]?

    
    override func loadView() {
        super.loadView()
        view.backgroundColor = Appearance.backgroundColor
        setupScrollView(for: scrollview, parent: self.view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

extension MammalComparisonViewController {
    //MARK: Setup views
    private func setupViews(){
        assert(imageViews?.count == descriptionViews?.count)
        assert(imageViews?.count == headingViews?.count)
        for index in imageViews!.indices{
            setupHeadings(index: index)
            setupImages(index: index)
            setupSpotsAndLabels(index: index)
            setupDescription(index: index)
            setupLines(index: index)
        }
        horizontalLines!.last!.isHidden = true
        descriptionViews!.last!.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor, constant: -Appearance.spacing).isActive = true
    }
    
    private func setupHeadings(index: Int){
        let headingView = headingViews![index]
        headingView.translatesAutoresizingMaskIntoConstraints = false
        headingView.textAlignment = .left
        headingView.attributedText = NSAttributedString(string: animals[index].shortName, attributes: Appearance.subheadingAttributes)
        scrollview.addSubview(headingView)
        if index == 0{
            NSLayoutConstraint.activate([
                headingView.topAnchor.constraint(equalTo: scrollview.topAnchor, constant: Appearance.spacing)
            ])
        }else {
            NSLayoutConstraint.activate([
                headingView.topAnchor.constraint(equalTo: horizontalLines![index-1].bottomAnchor, constant: Appearance.spacing)
            ])
        }
        NSLayoutConstraint.activate([
            headingView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant:  Appearance.padding),
            headingView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Appearance.padding),
        ])
    }
    private func setupImages(index: Int){
        let imageView = imageViews![index]
        imageView.translatesAutoresizingMaskIntoConstraints = false
        var image : UIImage?
        var counter = 0
        while (image == nil) && (counter + 1 < animals[index].transparentImages.count){
            image = UIImage(named: animals[index].transparentImages[counter].0)
            counter += 1
        }
        assert(image != nil)
        imageView.image = image
        //let scaleFactor = view.frame.width / image!.size.width
        //imageView.contentScaleFactor = scaleFactor
        imageView.contentMode = .scaleAspectFit
        scrollview.addSubview(imageView)
        let futureWidth = self.view.frame.width
        let futureHeight = imageView.image!.size.height/imageView.image!.size.width * futureWidth
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: headingViews![index].bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            //imageView.widthAnchor.constraint(equalToConstant: futureWidth),
            imageView.heightAnchor.constraint(equalToConstant: futureHeight),
        ])
        imageView.isUserInteractionEnabled = true
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(hideAllInfos(_:)))
        tabGesture.numberOfTapsRequired = 1
        tabGesture.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(tabGesture)
    }
    private func setupSpotsAndLabels(index: Int){
        let imageView =  imageViews![index]
        
        for spotIndex in spots![index]!.indices{
    
            let spotView =  spots![index]![spotIndex]
            imageView.addSubview(spotView)
            let spot = Dot()
            spotView.addSubview(spot)
            spot.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                spot.centerXAnchor.constraint(equalTo: spotView.centerXAnchor),
                spot.centerYAnchor.constraint(equalTo: spotView.centerYAnchor),
                spot.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: spotSizeFactor),
                spot.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: spotSizeFactor),
            ])
            spot.backgroundColor = Appearance.backgroundColor
            spot.layer.borderColor = Appearance.brightColor.cgColor
            spot.layer.borderWidth = 3
            spotView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            
            // Add animation
            UIView.animate(withDuration: 0.8, delay: 0.8, options: [.repeat, .autoreverse, .curveEaseOut, .curveEaseIn, .allowUserInteraction], animations: {
                spot.alpha = 0.2
            }, completion: nil)

            
            let selectedInfoView = infoViews![index]![spotIndex]
            let infoLabel = UILabel()
            let coordinates = animals[index].diffCoordinates![spotIndex]
            spotView.translatesAutoresizingMaskIntoConstraints = false
            selectedInfoView.translatesAutoresizingMaskIntoConstraints = false
            infoLabel.translatesAutoresizingMaskIntoConstraints = false
            
            selectedInfoView.backgroundColor = Appearance.backgroundColor
            selectedInfoView.layer.borderColor = Appearance.brightColor.cgColor
            selectedInfoView.layer.borderWidth = 2
            let attString = NSAttributedString(string: animals[index].differences![spotIndex], attributes: Appearance.paragraphAttributes)
            let infoBoxHeight = imageView.bounds.height*maxImageHeightRatio/2
            let infoBoxWidth = attString.width(withConstrainedHeight: infoBoxHeight) + Appearance.padding
            infoLabel.attributedText = attString
            infoLabel.numberOfLines = 0
            infoLabel.textAlignment = .center
            infoLabel.lineBreakMode = .byWordWrapping
            selectedInfoView.addSubview(infoLabel)
            NSLayoutConstraint.activate([
                infoLabel.topAnchor.constraint(equalTo: selectedInfoView.topAnchor, constant: Appearance.spacing/2),
                infoLabel.bottomAnchor.constraint(equalTo: selectedInfoView.bottomAnchor,constant: -Appearance.spacing/2),
                infoLabel.leadingAnchor.constraint(equalTo: selectedInfoView.leadingAnchor, constant: Appearance.padding/2),
                infoLabel.trailingAnchor.constraint(equalTo: selectedInfoView.trailingAnchor, constant: -Appearance.padding/2)
            ])
            infoLabel.clipsToBounds = true
            
            imageView.addSubview(selectedInfoView)
            let futureWidth = self.view.frame.width
            let futureHeight = imageView.image!.size.height/imageView.image!.size.width * futureWidth
            NSLayoutConstraint.activate([
                spotView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: futureWidth * coordinates.x),
                spotView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: futureHeight * coordinates.y),
                spotView.widthAnchor.constraint(equalToConstant: 44),
                spotView.heightAnchor.constraint(equalToConstant: 44),

                //spot.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: spotSizeFactor),
                //spot.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: spotSizeFactor),
            ])
            NSLayoutConstraint.activate([
                selectedInfoView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 0),
                selectedInfoView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor,constant: 0),
                selectedInfoView.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: maxImageWidthRatio),
                selectedInfoView.heightAnchor.constraint(greaterThanOrEqualTo: imageView.heightAnchor, multiplier: maxImageHeightRatio)
            ])
            let widthConstraint = selectedInfoView.widthAnchor.constraint(equalToConstant: infoBoxWidth)
            widthConstraint.priority = .defaultLow
            widthConstraint.isActive = true

            selectedInfoView.layer.cornerRadius = textCornerRadius
            selectedInfoView.clipsToBounds = true
            selectedInfoView.isHidden = true
            addGestureToSpot(animalIndex: index, spotIndex: spotIndex)
            spotView.isUserInteractionEnabled = true
        }
    }
    private func setupDescription(index: Int){
        let descriptionView = descriptionViews![index]
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        scrollview.addSubview(descriptionView)
        descriptionView.attributedText = NSAttributedString(string: animals[index].diffDescription ?? "", attributes: Appearance.paragraphAttributes)
        descriptionView.numberOfLines = 0
        NSLayoutConstraint.activate([
            descriptionView.topAnchor.constraint(equalTo: imageViews![index].bottomAnchor),
            descriptionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding),
            descriptionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Appearance.padding),
        ])
    }
    
    private func setupLines(index: Int){
        let horizontalLine = horizontalLines![index]
        Etoscha.setupLorizontalLine(for: horizontalLine, topAnchor: descriptionViews![index], mainView: scrollview, parentView: self.view)
    }
    
    private func addGestureToSpot(animalIndex: Int, spotIndex: Int){
        let spot = spots![animalIndex]![spotIndex]
        spot.tag = animalIndex*10 + spotIndex
        let hover = UITapGestureRecognizer(target: self, action: #selector(clickOnSpot(_:)))
        hover.numberOfTapsRequired = 1
        hover.numberOfTouchesRequired = 1
        spot.addGestureRecognizer(hover)
    }
    
    private func containSameNumberOfSpots()-> Bool{
        let size = infoViews!.first!!.count
        for index in infoViews!.indices{
            if infoViews![index]?.count != size{
                return false
            }
        }
        return true
    }
    
    @objc func clickOnSpot(_ recognizer: UITapGestureRecognizer){
        let spotClicked = recognizer.view!
        let clickedSpot = spotClicked.tag % 10
        let clickedAnimal = spotClicked.tag / 10
        hideAllInfos(recognizer)
        infoViews![clickedAnimal]![clickedSpot].isHidden = false
        
        // Activate all parallel spots
        if containSameNumberOfSpots(){
            for index in infoViews!.indices{
                let label = infoViews![index]![clickedSpot]
                label.isHidden = false
                label.superview?.bringSubviewToFront(label)
            }
        }
    }
    @objc func hideAllInfos(_ recognizer: UITapGestureRecognizer){
        for i in infoViews!.indices{
            let labels = infoViews![i]
            labels!.forEach({ lab in
                lab.isHidden = true
            })
        }
    }
}
