//
//  WelcomeViewController.swift
//  Etoscha
//
//  Created by Björn Roxin on 27.05.21.
//

import UIKit
import FirebaseAnalytics

class WelcomeViewController: UIViewController {
    //MARK: Constants
    let spacing : CGFloat = 20
    let padding : CGFloat = 20
    
    //MARK: Views
    private var scrollView = UIScrollView()
    private var headingText = UILabel()
    private var whatToExpectHeading = UILabel()
    
    private var horizontalLine1 = UIView()
    private var paragraphText1 = UILabel()
    private var paragraphAnswer1 = UILabel()
    private var paragraphIcon1 = UIImageView()
    
    private var horizontalLine2 = UIView()
    private var paragraphText2 = UILabel()
    private var paragraphAnswer2 = UILabel()
    private var paragraphIcon2 = UIImageView()
    
    private var horizontalLine3 = UIView()
    private var paragraphText3 = UILabel()
    private var paragraphAnswer3 = UILabel()
    private var paragraphIcon3 = UIImageView()
    
    private var horizontalLine4 = UIView()
    private var paragraphText4 = UILabel()
    private var paragraphAnswer4 = UILabel()
    private var paragraphIcon4 = UIImageView()
    
    private var horizontalLine5 = UIView()
    private var lastParagraph = UILabel()
    
    //MARK: Action
    @objc private func touchedQuestion(_ sender: UITapGestureRecognizer){
        if sender.view == paragraphAnswer1 || sender.view == paragraphText1 || sender.view == paragraphIcon1{
            Analytics.logEvent(MyAnalyticsEvents.clickedAnWelcomeItem.rawValue, parameters: [MyAnalyticsParameters.welcomeItems.rawValue: Destinations.Mammals.rawValue])
            let vc = MammalCollectionViewController()
            vc.view.backgroundColor = Appearance.backgroundColor
            navigationController?.pushViewController(vc, animated: true)
        }
        if sender.view == paragraphAnswer2 || sender.view == paragraphText2 || sender.view == paragraphIcon2{
            Analytics.logEvent(MyAnalyticsEvents.clickedAnWelcomeItem.rawValue, parameters: [MyAnalyticsParameters.welcomeItems.rawValue: Destinations.GateTimes.rawValue])
            let vc = GateTimesViewController()
            vc.view.backgroundColor = Appearance.backgroundColor
            navigationController?.pushViewController(vc, animated: true)
        }
        if sender.view == paragraphAnswer3 || sender.view == paragraphText3 || sender.view == paragraphIcon3{
            Analytics.logEvent(MyAnalyticsEvents.clickedAnWelcomeItem.rawValue, parameters: [MyAnalyticsParameters.welcomeItems.rawValue: Destinations.Sights.rawValue])
            let vc = SightsViewController()
            vc.view.backgroundColor = Appearance.backgroundColor
            navigationController?.pushViewController(vc, animated: true)
        }
        if sender.view == paragraphAnswer4 || sender.view == paragraphText4 || sender.view == paragraphIcon4{
            Analytics.logEvent(MyAnalyticsEvents.clickedAnWelcomeItem.rawValue, parameters: [MyAnalyticsParameters.welcomeItems.rawValue: Destinations.ContactNumber.rawValue])
            let vc = ContactNumbersViewController()
            vc.view.backgroundColor = Appearance.backgroundColor
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //MARK: Load View
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupDefaultNavBar()
        addSingleTitleToNavBar(title: getTitle())
        view.backgroundColor = Appearance.backgroundColor
    }

}
extension WelcomeViewController{
    //MARK: Setup views
    private func setupViews(){
        setupScrollView()
        setupHeading()
        setupWhatToExpect()
        setupParagraph(line: horizontalLine1, textLabel: paragraphText1, answerLabel: paragraphAnswer1, iconView: paragraphIcon1, topView: whatToExpectHeading, text: getQuestionText(pargraph: 1), answer: getAnswerText(pargraph: 1), icon: "paw-solid")
        setupParagraph(line: horizontalLine2, textLabel: paragraphText2, answerLabel: paragraphAnswer2, iconView: paragraphIcon2, topView: paragraphAnswer1, text: getQuestionText(pargraph: 2), answer: getAnswerText(pargraph: 2), icon: "clock-solid")
        setupParagraph(line: horizontalLine3, textLabel: paragraphText3, answerLabel: paragraphAnswer3, iconView: paragraphIcon3, topView: paragraphAnswer2, text: getQuestionText(pargraph: 3), answer: getAnswerText(pargraph: 3), icon: "TickWider")
        setupParagraph(line: horizontalLine4, textLabel: paragraphText4, answerLabel: paragraphAnswer4, iconView: paragraphIcon4, topView: paragraphAnswer3, text: getQuestionText(pargraph: 4), answer: getAnswerText(pargraph: 4), icon: "phone-solid")
        setupEnd()
        addBottomConstraint()
    }
    
    private func addBottomConstraint(){
        NSLayoutConstraint.activate([
            lastParagraph.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -spacing)
        ])
    }
    
    private func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.isScrollEnabled = true
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupHeading(){
        headingText.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(headingText)
        NSLayoutConstraint.activate([
            headingText.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: spacing),
            headingText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            headingText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
        ])
        let textAttribute : [NSAttributedString.Key: Any] =
            [
                .foregroundColor: Appearance.black,
                .font: UIFontMetrics(forTextStyle: .title1).scaledFont(for: UIFont(name: Appearance.semiBold, size: 18)!),
            ]
        headingText.attributedText = NSAttributedString(string: getGreating(), attributes: textAttribute)
        headingText.numberOfLines = 0
        headingText.textAlignment = .center
    }
    private func setupWhatToExpect(){
        whatToExpectHeading.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(whatToExpectHeading)
        NSLayoutConstraint.activate([
            whatToExpectHeading.topAnchor.constraint(equalTo: headingText.bottomAnchor, constant: spacing),
            whatToExpectHeading.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            whatToExpectHeading.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        let textAttribute : [NSAttributedString.Key: Any] =
            [
                .foregroundColor: Appearance.primaryColor,
                .font: UIFontMetrics(forTextStyle: .title2).scaledFont(for: UIFont(name: Appearance.semiBold, size: 18)!),
            ]
        whatToExpectHeading.attributedText = NSAttributedString(string: getSubheading(), attributes: textAttribute)
        whatToExpectHeading.numberOfLines = 0
        whatToExpectHeading.textAlignment = .center
    }
    
    private func setupParagraph(line: UIView, textLabel: UILabel, answerLabel: UILabel,iconView: UIImageView, topView: UIView, text: String, answer: String, icon: String){
        line.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(line)
        scrollView.addSubview(textLabel)
        scrollView.addSubview(answerLabel)
        scrollView.addSubview(iconView)
        NSLayoutConstraint.activate([
            line.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: spacing),
            line.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            line.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7),
            line.heightAnchor.constraint(equalToConstant: Appearance.horizontalLineWidth)
        ])
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: line.bottomAnchor, constant: spacing),
            textLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: padding),
            textLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -padding),
        ])
        NSLayoutConstraint.activate([
            answerLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: spacing),
            answerLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: padding),
            answerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
        ])
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: line.topAnchor),
            iconView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            iconView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor,multiplier: 0.1),
            iconView.bottomAnchor.constraint(equalTo: answerLabel.bottomAnchor),
        ])
        let textAttribute : [NSAttributedString.Key: Any] =
            [
                .foregroundColor: Appearance.black,
                .font: UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: Appearance.regular, size: 16)!),
                .paragraphStyle: Appearance.paragraphStyle
            ]
        let answerAttribute : [NSAttributedString.Key: Any] =
            [
                .foregroundColor: Appearance.gray,
                .font: UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: Appearance.regular, size: 16)!),
                .paragraphStyle: Appearance.paragraphStyle
            ]
        line.backgroundColor = Appearance.primaryColor
        textLabel.attributedText = NSAttributedString(string: text, attributes: textAttribute)
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .justified
        answerLabel.attributedText = NSAttributedString(string: answer, attributes: answerAttribute)
        answerLabel.numberOfLines = 0
        answerLabel.textAlignment = .justified
        iconView.image = UIImage(named: icon)?.withTintColor(Appearance.primaryColor)
        iconView.contentMode = .scaleAspectFit
        
        //Add Gesture Recognizer
        addGesture(to: textLabel)
        addGesture(to: answerLabel)
        addGesture(to: iconView)
    }
    
    private func setupEnd(){
        horizontalLine5.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(horizontalLine5)
        NSLayoutConstraint.activate([
            horizontalLine5.topAnchor.constraint(equalTo: paragraphAnswer4.bottomAnchor, constant: spacing),
            horizontalLine5.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            horizontalLine5.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7),
            horizontalLine5.heightAnchor.constraint(equalToConstant: Appearance.horizontalLineWidth)
        ])
        horizontalLine5.backgroundColor = Appearance.primaryColor
        
        //End Paragraph
        let textAttribute : [NSAttributedString.Key: Any] =
            [
                .foregroundColor: Appearance.black,
                .font: UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: Appearance.regular, size: 16)!),
            ]
        lastParagraph.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(lastParagraph)
        NSLayoutConstraint.activate([
            lastParagraph.topAnchor.constraint(equalTo: horizontalLine5.bottomAnchor, constant: spacing),
            lastParagraph.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            lastParagraph.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
        ])
        lastParagraph.attributedText = NSAttributedString(string: getEndText(), attributes: textAttribute)
        lastParagraph.numberOfLines = 0
        lastParagraph.textAlignment = .justified
    }
}

extension WelcomeViewController{
    //MARK: Gesture
    private func addGesture(to view: UIView){
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(touchedQuestion(_:)))
        tabGesture.numberOfTouchesRequired = 1
        tabGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tabGesture)
        view.isUserInteractionEnabled = true
    }
}

extension WelcomeViewController{
    //MARK: Localized Stings
    private func getTitle()->String{
        return getLocalizedString(for: "_title")
    }
    private func getSubheading()->String{
        return getLocalizedString(for: "_subheading")
    }
    private func getGreating()->String{
        return getLocalizedString(for: "_greating")
    }
    private func getQuestionText(pargraph number: Int)-> String{
        return getLocalizedString(for: "_question\(number)")
    }
    private func getAnswerText(pargraph number: Int)-> String{
        return getLocalizedString(for: "_answer\(number)")
    }
    private func getEndText()-> String{
        return getLocalizedString(for: "_end")
    }
    
    private func getLocalizedString(for string: String)->String{
        return NSLocalizedString(EtoshaViews.welcomeView.rawValue+string, tableName: "Texts", bundle: .main, value: ErrorHandler.localizedStringNotFound, comment: "Welcome View")
    }
}

extension WelcomeViewController{
    enum Destinations:String{
        case Mammals
        case GateTimes
        case ContactNumber
        case Sights
    }
}
