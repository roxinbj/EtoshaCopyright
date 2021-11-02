//
//  CampController.swift
//  Etoscha
//
//  Created by Björn Roxin on 12.05.21.
//

import UIKit
import MessageUI
import Firebase

class CampController : UIViewController {
    //MARK: Constants
    let imageHeight : CGFloat = 0.6
    let cellheight : CGFloat = 50
    let aspectRatio : CGFloat = 0.5
    
    //MARK: Views
    private var scrollView = UIScrollView()
    private var campImageView  = UIImageViewBluredBackground()
    private var buttonStack = UIStackView()
    private var descriptionView  = UILabel()
    
    private var horizontalLine = UIView()
    private var accommodationHeading = UILabel()
    private var accommodationText = UILabel()

    private var horizontalLine2 = UIView()
    private var facilitiesHeading = UILabel()
    private var facilitiesView  = UIStackView()

    
    //MARK: Data
    var campName : Accommodations = .Halali {
        didSet{
            campImageView.configure(withImageName: campName.mainImage, aspect: aspectRatio)
            facilityCollection = campName.facilities
        }
    }
    private var imageNames : [String]{
        return campName.images
    }
    private var facilityCollection = [Facilities](){
        didSet{
            facilitiesView = UIStackView()
            fillIconStack()
        }
    }
    
    private var descriptionText : NSAttributedString {
        return NSAttributedString(string: campName.description, attributes: Appearance.paragraphAttributes)
    }
    
   @objc private func touchPhoneButton(){
        AppUtility.makeCall(to: self.campName.telephone)
    }
    @objc func swipeRecognised(_ sender: UISwipeGestureRecognizer){
        print("Swipe")
        switch sender.direction {
        case .right:
            imageNumber -= 1
        case .left:
            imageNumber += 1
        default:
            break
        }
        campImageView.configure(withImageName: imageNames[imageNumber], aspect: aspectRatio)
    }
    
    private var imageNumber : Int = 0 {
        didSet{
            let rightestIndexValue = imageNames.count - 1
            if imageNames.count != 0 {
                // Reached left boundary -> choose rightest image
                if imageNumber < 0 {
                    imageNumber = rightestIndexValue
                    // Reached right boundary --> choose first image
                }else if imageNumber > rightestIndexValue {
                    imageNumber = 0
                }
            }
        }
    }
    
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = Appearance.backgroundColor
        setupScrollView(for: scrollView, parent: view)
        //setupContentView()
        setupImageView()
        setupButtonStack()
        setupDescriptionView()
        setupLorizontalLine(for: horizontalLine, topAnchor: descriptionView, mainView: self.view, parentView: scrollView)
        
        setupHeading(for: accommodationHeading, topAnchor: horizontalLine, with: MyStrings.accommodation.locString, mainView: self.view, parentView: scrollView)
        let bulletStrings = self.campName.accommodationText.components(separatedBy: "•")
        let accommStrings = bulletPointList(strings: bulletStrings)

        setupParagraph(for: accommodationText, topAnchor: accommodationHeading, with: accommStrings, mainView: self.view, parentView: scrollView)
        
        setupLorizontalLine(for: horizontalLine2, topAnchor: accommodationText, mainView: self.view, parentView: scrollView)
        setupHeading(for: facilitiesHeading, topAnchor: horizontalLine2, with: MyStrings.facilities.locString, mainView: self.view, parentView: scrollView)
        setupFacilities()
        NSLayoutConstraint.activate([
            facilitiesView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Appearance.spacing)
        ])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setupDefaultNavBar()
        //self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(openMap))

        self.addSingleTitleToNavBar(title: campName.shortName)
//        self.addIconsToNavBarRight(icons: [UIImage(named: "phone-solid")!.withTintColor(Appearance.primaryColor),UIImage(named: "at-solid")!.withTintColor(Appearance.primaryColor),UIImage(named: "map-marker-alt-solid")!.withTintColor(Appearance.primaryColor)], targets: [#selector(touchPhoneButton),#selector(openBookingPage),#selector(openMap)])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Analytics.logEvent(AnalyticsEventScreenView, parameters: [AnalyticsParameterScreenName: self.campName.rawValue,
                                                                  AnalyticsParameterScreenClass: self])
    }
    
    func bulletPointList(strings: [String]) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = 15
        paragraphStyle.minimumLineHeight = 22
        paragraphStyle.maximumLineHeight = 22
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15)]
        paragraphStyle.hyphenationFactor = 1

        let stringAttributes = [
            NSAttributedString.Key.font: UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: Appearance.regular, size: 16)!),
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]

        let string = strings.map({ "•\t\($0)" }).joined(separator: "\n")

        return NSAttributedString(string: string,
                                  attributes: stringAttributes as [NSAttributedString.Key : Any])
    }
}
//MARK: Setup Functions
extension CampController{
    
    private func setupImageView() {
        campImageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(campImageView)
        //campImageView.contentMode = .scaleAspectFit
        //campImageView.clipsToBounds = true
        NSLayoutConstraint.activate([
            campImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            campImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            campImageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            campImageView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: imageHeight)
        ])
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeRecognised(_:)))
        swipeRightGesture.direction = .right
        swipeRightGesture.numberOfTouchesRequired = 1
        campImageView.addGestureRecognizer(swipeRightGesture)
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeRecognised(_:)))
        swipeLeftGesture.direction = .left
        campImageView.addGestureRecognizer(swipeLeftGesture)
        campImageView.isUserInteractionEnabled = true
        scrollView.bringSubviewToFront(campImageView)
    }
    
    private func setupButtonStack(){
        scrollView.addSubview(buttonStack)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStack.topAnchor.constraint(equalTo: campImageView.bottomAnchor,constant: Appearance.spacing/2),
            buttonStack.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: Appearance.padding),
            buttonStack.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: -Appearance.padding),
        ])
        
        let images = ["phone-solid","at-solid","map-marker-alt-solid"]
        let names = [NSLocalizedString("Call", tableName: "Texts", bundle: .main, value: "NO text found", comment: ""),
                     NSLocalizedString("Book", tableName: "Texts", bundle: .main, value: "NO text found", comment: ""),
                     NSLocalizedString("Map", tableName: "Texts", bundle: .main, value: "NO text found", comment: "")]
        let actions = [#selector(touchPhoneButton),#selector(openBookingPage),#selector(openMap)]
        
        for index in images.indices {
            let button = VerticalButton()
            buttonStack.addArrangedSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.configure(withImageName: images[index], title: names[index], action: actions[index], target: self)
        
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2),
                button.heightAnchor.constraint(equalTo: button.widthAnchor, multiplier: 1),
            ])
        }
        buttonStack.axis = .horizontal
        buttonStack.distribution = .equalSpacing
        buttonStack.spacing = 10
    }
    
    private func setupDescriptionView() {
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(descriptionView)
        NSLayoutConstraint.activate([
            descriptionView.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: Appearance.spacing),
            descriptionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding),
            descriptionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Appearance.padding),
            //descriptionView.heightAnchor.constraint(equalToConstant: descriptionText.height(withConstrainedWidth: self.view.frame.width))
        ])
        
        descriptionView.attributedText = descriptionText
        descriptionView.textAlignment = .justified
        descriptionView.numberOfLines = 0
        //descriptionView.backgroundColor = UIColor.yellow
    }
    
    private func setupFacilities() {
        facilitiesView.translatesAutoresizingMaskIntoConstraints = false
        facilitiesView.alignment = .fill
        facilitiesView.distribution = .equalSpacing
        facilitiesView.axis = .vertical
        scrollView.addSubview(facilitiesView)
        NSLayoutConstraint.activate([
            facilitiesView.topAnchor.constraint(equalTo: facilitiesHeading.bottomAnchor, constant: Appearance.spacing),
            facilitiesView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Appearance.padding),
            facilitiesView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Appearance.padding)
        ])
        
    }
    private func fillIconStack(){
        let aspectRatio = CGFloat(0.35)
        let columns = 2
        let rows = facilityCollection.count / columns + facilityCollection.count % columns
        
        var index = 0
        for _ in 0..<rows {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 10
            rowStack.distribution = .fillEqually
            for _ in 0..<columns{
                if index < facilityCollection.count{
                    let card = IconWithNameView()
                    card.widthAnchor.constraint(equalTo: card.heightAnchor, multiplier: 1/aspectRatio).isActive = true
                    card.configure(withImageName: facilityCollection[index].mainImage, title: facilityCollection[index].shortName)
                    index += 1
                    rowStack.addArrangedSubview(card)
                }
                else {
                    rowStack.addArrangedSubview(UIView())
                }
            }
            facilitiesView.addArrangedSubview(rowStack)
        }
    }
}

extension CampController : MFMailComposeViewControllerDelegate {
    @objc func openMap(){
        if let numberOfControllers = navigationController?.viewControllers.count{
            if let mapVC = navigationController?.viewControllers[numberOfControllers - 2] as? MapViewController{
                mapVC.focusCamp = nil //reset focus to keep current scrollview zoom settings
                navigationController?.popViewController(animated: true)
            }else {
                let vc = MapViewController()
                vc.focusCamp = self.campName
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    @objc func openBookingPage(){
        if let url = URL(string: self.campName.url) {
            UIApplication.shared.open(url)
        }
    }
    
}

extension CampController{
    enum MyStrings:String{
        case facilities = "_facilities"
        case accommodation = "_accommodation"
        
        var locString : String {
            getLocalizedString(for: self.rawValue, viewType: EtoshaViews.campsView)
        }
    }
}


class VerticalButton: UIView {
    let featuredPhotoView = UIImageView()
    let titleView = UILabel()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        featuredPhotoView.layer.cornerRadius = 5
        featuredPhotoView.layer.masksToBounds = true
        //self.layer.cornerRadius = 10
        //self.layer.borderWidth = 0.8
        //self.layer.borderColor = Appearance.primaryColor.cgColor
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        featuredPhotoView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(featuredPhotoView)
        
        NSLayoutConstraint.activate([
            featuredPhotoView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            featuredPhotoView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            featuredPhotoView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            featuredPhotoView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            //featuredPhotoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            featuredPhotoView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45)
        ])
        featuredPhotoView.contentMode = .scaleAspectFit
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(titleView)
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: featuredPhotoView.bottomAnchor, constant: 5),
            titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            titleView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleView.heightAnchor.constraint(greaterThanOrEqualTo: self.heightAnchor, multiplier: 0.3)
        ])
    }
    
    func configure(withImageName imageName: String, title: String, action: Selector, target: Any?) {
        
        let image = UIImage(named: imageName)
        let fontColor = Appearance.primaryColor
        let backgroundColor = Appearance.backgroundColor
        
        featuredPhotoView.image = image?.withRenderingMode(.alwaysOriginal).withTintColor(Appearance.primaryColor)
        self.backgroundColor = backgroundColor

        
        let paragraphstyle = NSMutableParagraphStyle()
        paragraphstyle.hyphenationFactor = 1
        paragraphstyle.alignment = .center
               
        let attributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: fontColor,
            .font: UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: Appearance.semiBold, size: 14)!),
            .paragraphStyle: paragraphstyle
        ]
       
        let attributedString = NSAttributedString(string: title, attributes: attributes)
        titleView.attributedText = attributedString
        titleView.numberOfLines = 2
        titleView.minimumScaleFactor = 0.5
        titleView.lineBreakMode  = .byTruncatingTail
        //titleView.adjustsFontSizeToFitWidth = true
        titleView.textAlignment = NSTextAlignment.center
        
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTouchesRequired = 1
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
    }
}
