//
//  GateTimesViewController.swift
//  Etoscha
//
//  Created by Björn Roxin on 26.05.21.
//

import UIKit
import FirebaseAnalytics

class GateTimesViewController: UIViewController {

    //MARK: Views
    private var todayButton = UIButton()
    private var tomorrowButton = UIButton()
    
    private var descriptionText = UILabel()
    private var openingLabel = UILabel()
    private var openingAnalogView = AnalogClockView()
    private var closingLabel = UILabel()
    private var closingAnalogView = AnalogClockView()
    
    //MARK: Data
    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let gateTime = GateTimes()
    private var buttonPressedCounter = 0 {
        didSet{
            if buttonPressedCounter > 2 {//&&
                //(gateTime.getDate(for: .today, with: .opening) == gateTime.getDate(for: .tomorrow, with: .opening)) ||
                //(gateTime.getDate(for: .today, with: .closing) == gateTime.getDate(for: .tomorrow, with: .closing)){
                runAlert()
                buttonPressedCounter = 0
            }
        }
    }
    private var activeTime : GateTimes.DayOption = .today {
        didSet{
            if activeTime == .today{
                setButtonAppearance(for: todayButton,as: true)
                setButtonAppearance(for: tomorrowButton,as: false)
            }
            if activeTime == .tomorrow{
                setButtonAppearance(for: todayButton,as: false)
                setButtonAppearance(for: tomorrowButton,as: true)
            }
        }
    }
    
    //MARK: Constants
    private let horizonatlSpace : CGFloat = 10
    private let verticalSpace : CGFloat = 20
    private let headingTextSize : CGFloat = 18
    private let paragraphTextSize : CGFloat = 16
    private let buttonCornerRadius : CGFloat = 5
    
    //MARK: Actions
    @objc private func touchDayButton(_ sender: UIButton){
        Analytics.logEvent(MyAnalyticsEvents.pressedGateButton.rawValue, parameters: ["DatePressed": sender.tag, "Counter": buttonPressedCounter])

        buttonPressedCounter += 1
        if let dayOption = GateTimes.DayOption(rawValue: sender.tag){
            activeTime = dayOption
          
            // Set Analog Time
            openingAnalogView.date = gateTime.getDate(for: activeTime, with: .opening)
            closingAnalogView.date = gateTime.getDate(for: activeTime, with: .closing)
        }
    }
    
    private func runAlert(){
        do {
            if let onboarding = try context.fetch(Onboarding.fetchRequest()).first{
                if onboarding.isTimeDiffDemoDone == false {
                    let alert = UIAlertController(title: MyStrings.alertHeading.locString, message: MyStrings.alertText.locString, preferredStyle: .alert)
                    //alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = Appearance.backgroundColor
                    //alert.view.tintColor = Appearance.black
                    alert.addAction(UIAlertAction(title: MyStrings.alertOkButton.locString, style: .default, handler: {action in
                        onboarding.isTimeDiffDemoDone = true
                        do { try self.context.save()
                        }catch{}
                    }))
                    alert.addAction(UIAlertAction(title: MyStrings.alertRepeatButton.locString, style: .default, handler: {action in
                        onboarding.isTimeDiffDemoDone = false
                        do { try self.context.save()
                        }catch{}
                    }))
                    present(alert, animated: true, completion: nil)
                }
            }
        }catch{}
    }
    
    //MARK: Load View
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        touchDayButton(todayButton)
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = Appearance.backgroundColor
        setupDefaultNavBar()
        addSingleTitleToNavBar(title: MyStrings.title.locString)
        setupButtons()
        setupDescriptionText()
        setupOpeningClockViews()
        setupClosingClockViews()
    }
}

//MARK: Appearance
extension GateTimesViewController {
    private func setButtonAppearance(for button: UIButton, as selected: Bool){
        if selected{
            button.backgroundColor = Appearance.primaryColor
            button.setTitleColor(UIColor.white,for: .normal)
        }else {
            button.backgroundColor = UIColor.white
            button.setTitleColor(Appearance.primaryColor, for: .normal)
        }
    }
}

//MARK: Setup Functions
extension GateTimesViewController {
    private func setupButtons() {
        todayButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(todayButton)
        NSLayoutConstraint.activate([
            todayButton.topAnchor.constraint(equalTo:  self.view.safeAreaLayoutGuide.topAnchor, constant: verticalSpace),
            todayButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: horizonatlSpace),
            todayButton.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.125),
        ])
        
        // Mark as selected
        tomorrowButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tomorrowButton)
        NSLayoutConstraint.activate([
            tomorrowButton.topAnchor.constraint(equalTo:  self.view.safeAreaLayoutGuide.topAnchor, constant: verticalSpace),
            tomorrowButton.leadingAnchor.constraint(equalTo: todayButton.trailingAnchor, constant: horizonatlSpace),
            tomorrowButton.trailingAnchor.constraint(equalTo:  self.view.safeAreaLayoutGuide.trailingAnchor, constant: -horizonatlSpace),
            tomorrowButton.widthAnchor.constraint(equalTo: todayButton.widthAnchor, multiplier: 1),
            tomorrowButton.heightAnchor.constraint(equalTo: todayButton.heightAnchor, multiplier: 1),
        ])
        
        todayButton.layer.cornerRadius = buttonCornerRadius
        todayButton.layer.borderWidth = 1
        todayButton.layer.borderColor = Appearance.primaryColor.cgColor
        todayButton.setTitle(MyStrings.todayButton.locString, for: .normal)
        todayButton.tag = GateTimes.DayOption.today.rawValue
        todayButton.addTarget(self, action: #selector(touchDayButton(_:)), for: .touchUpInside)
        setButtonAppearance(for: todayButton, as: true)
        // Mark as unselected
        tomorrowButton.layer.cornerRadius = buttonCornerRadius
        tomorrowButton.layer.borderWidth = 1
        tomorrowButton.layer.borderColor = Appearance.primaryColor.cgColor
        tomorrowButton.tag = GateTimes.DayOption.tomorrow.rawValue
        setButtonAppearance(for: tomorrowButton, as: false)
        tomorrowButton.setTitle(MyStrings.tomorrowButton.locString, for: .normal)
        tomorrowButton.addTarget(self, action: #selector(touchDayButton(_:)), for: .touchUpInside)
    }
    
    private func setupDescriptionText(){
        let paragraphstyle = NSMutableParagraphStyle()
        paragraphstyle.alignment = .justified
        paragraphstyle.hyphenationFactor = 1
               
        let attributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: Appearance.black,
            .font: UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: Appearance.regular, size: paragraphTextSize)!),
            .paragraphStyle: paragraphstyle
        ]
       
        
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionText)
        NSLayoutConstraint.activate([
            descriptionText.topAnchor.constraint(equalTo: todayButton.bottomAnchor, constant: verticalSpace),
            descriptionText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: horizonatlSpace),
            descriptionText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -horizonatlSpace),
            //descriptionText.heightAnchor.constraint(greaterThanOrEqualToConstant: attributedString.height(withConstrainedWidth: view.frame.width)*1.5)
        ])
        let attributedString = NSAttributedString(string: MyStrings.infoText.locString, attributes: attributes)
        descriptionText.attributedText = attributedString
        descriptionText.textAlignment = .justified
        descriptionText.numberOfLines = 0
    }
    
    private func setupOpeningClockViews(){
        let paragraphstyle = NSMutableParagraphStyle()
        paragraphstyle.alignment = .center
        
        let attributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: Appearance.black,
            .font: UIFontMetrics(forTextStyle: .title1).scaledFont(for: UIFont(name: Appearance.semiBold, size: headingTextSize)!),
            .paragraphStyle: paragraphstyle
        ]
        let attributedString = NSAttributedString(string: MyStrings.openingTime.locString, attributes: attributes)
        openingLabel.attributedText = attributedString
        openingLabel.translatesAutoresizingMaskIntoConstraints = false
        openingLabel.sizeToFit()
        self.view.addSubview(openingLabel)
        NSLayoutConstraint.activate([
            openingLabel.topAnchor.constraint(equalTo:  descriptionText.bottomAnchor, constant: 20),
            openingLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            openingLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: attributedString.height(withConstrainedWidth: self.view.frame.width))

        ])
        
        openingAnalogView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(openingAnalogView)
        NSLayoutConstraint.activate([
            openingAnalogView.topAnchor.constraint(equalTo:  openingLabel.bottomAnchor, constant: 20),
            openingAnalogView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            openingAnalogView.widthAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.widthAnchor,multiplier: 0.5),
            openingAnalogView.heightAnchor.constraint(equalTo: openingAnalogView.widthAnchor,multiplier: 1),
        ])
        
    }
    private func setupClosingClockViews(){
        let paragraphstyle = NSMutableParagraphStyle()
        paragraphstyle.alignment = .center
            
        let attributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: Appearance.black,
            .font: UIFontMetrics(forTextStyle: .title1).scaledFont(for: UIFont(name: Appearance.semiBold, size: headingTextSize)!),
            .paragraphStyle: paragraphstyle
        ]
        let attributedString = NSAttributedString(string: MyStrings.closingTime.locString, attributes: attributes)
        closingLabel.attributedText = attributedString
        closingLabel.translatesAutoresizingMaskIntoConstraints = false
        closingLabel.sizeToFit()
        self.view.addSubview(closingLabel)
        NSLayoutConstraint.activate([
            closingLabel.topAnchor.constraint(equalTo:  openingAnalogView.bottomAnchor, constant: verticalSpace),
            closingLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            closingLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: attributedString.height(withConstrainedWidth: self.view.frame.width))

        ])
    
        closingAnalogView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(closingAnalogView)
        NSLayoutConstraint.activate([
            closingAnalogView.topAnchor.constraint(equalTo:  closingLabel.bottomAnchor, constant: verticalSpace),
            closingAnalogView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            closingAnalogView.widthAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.widthAnchor,multiplier: 0.5),
            closingAnalogView.heightAnchor.constraint(equalTo: closingAnalogView.widthAnchor,multiplier: 1),
            closingAnalogView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -verticalSpace),
            closingAnalogView.heightAnchor.constraint(equalTo: openingAnalogView.heightAnchor)
        ])
    }
}


struct GateTimes {
    
    enum DayOption: Int{
        case today
        case tomorrow
        
        var date : Date {
            switch self {
            case .today: return Date()
            case .tomorrow: return Date(timeIntervalSinceNow: TimeInterval(24*60*60))
            }
        }
    }
    
    enum TimeOption {
        case closing
        case opening
    }
    
    func getDate(for dayOption: DayOption,with timeOption: TimeOption) -> Date{
        // Get Date
        let date = dayOption.date
        
        // Get Times
        let index = getKey(to: date)!
        let openingDate = timeFormatter.date(from: table[index]!.0)!
        let closingDate = timeFormatter.date(from: table[index]!.1)!
        
        // Set Clocks
        switch timeOption {
        case .closing: return closingDate
        case .opening: return openingDate
        }
    }
    
    private func getKey(to closestDate: Date) -> String? {
        var foundEntry = false
        var counter = 0
        var checkedDate = closestDate
        while !foundEntry && counter < 30{
            let dateAsString = dateFormatter.string(from: checkedDate)
            // If Entry for that date is found
            if let _ = table.index(forKey: dateAsString){
                foundEntry = true
                return dateAsString
            }
            // Go back one day in time
            checkedDate = Date(timeInterval: -24*60*60, since: checkedDate)
            counter += 1
        }
        return nil
    }
    
    var table : [String : (String,String)] = ["01-01" : ("06:20","19:40"),
                                              "03-01" : ("06:25","19:40"),
                                              "10-01" : ("06:30","19:40"),
                                              "17-01" : ("06:35","19:40"),
                                              "24-01" : ("06:40","19:40"),
                                              "31-01" : ("06:40","19:40"),
                                              
                                              "01-02" : ("06:40","19:35"),
                                              "07-02" : ("06:45","19:35"),
                                              "14-02" : ("06:50","19:30"),
                                              "21-02" : ("06:50","19:25"),
                                              "28-02" : ("06:50","19:20"),
                                              
                                              "01-03" : ("06:55","19:20"),
                                              "07-03" : ("06:55","19:15"),
                                              "14-03" : ("07:00","19:10"),
                                              "21-03" : ("07:00","19:05"),
                                              "28-03" : ("07:00","19:00"),
                                              
                                              "01-04" : ("07:00","18:55"),
                                              "04-04" : ("07:05","18:50"),
                                              "11-04" : ("07:05","18:45"),
                                              "18-04" : ("07:10","18:40"),
                                              "25-04" : ("07:10","18:40"),
                                              
                                              "01-05" : ("07:10","18:35"),
                                              "02-05" : ("07:10","18:35"),
                                              "09-05" : ("07:15","18:30"),
                                              "16-05" : ("07:20","18:30"),
                                              "23-05" : ("07:20","18:25"),
                                              
                                              "01-06" : ("07:20","18:25"),
                                              "06-06" : ("07:25","18:25"),
                                              "13-06" : ("07:30","18:20"),
                                              "20-06" : ("07:30","18:30"),
                                              "27-06" : ("07:30","18:30"),
                                              
                                              "01-07" : ("07:30","18:30"),
                                              "04-07" : ("07:35","18:30"),
                                              "11-07" : ("07:30","18:35"),
                                              "18-07" : ("07:30","18:40"),
                                              "25-07" : ("07:25","18:40"),
                                              
                                              "01-08" : ("07:20","18:40"),
                                              "08-08" : ("07:20","18:40"),
                                              "15-08" : ("07:15","18:45"),
                                              "22-08" : ("07:10","18:45"),
                                              "29-08" : ("07:05","18:50"),
                                              
                                              "01-09" : ("07:00","18:50"),
                                              "05-09" : ("07:00","18:50"),
                                              "12-09" : ("06:55","18:50"),
                                              "19-09" : ("06:50","18:50"),
                                              "26-09" : ("06:40","18:50"),
                                              
                                              "01-10" : ("06:35","18:55"),
                                              "03-10" : ("06:35","18:55"),
                                              "10-10" : ("06:30","19:00"),
                                              "17-10" : ("06:20","19:00"),
                                              "24-10" : ("06:20","19:00"),
                                              
                                              "01-11" : ("06:15","19:05"),
                                              "07-11" : ("06:10","19:10"),
                                              "14-11" : ("06:10","19:15"),
                                              "21-11" : ("06:10","19:20"),
                                              "28-11" : ("06:10","19:20"),
                                              
                                              "01-12" : ("06:10","19:20"),
                                              "05-12" : ("06:10","19:25"),
                                              "12-12" : ("06:15","19:30"),
                                              "19-12" : ("06:15","19:35"),
                                              "26-12" : ("06:20","19:35")
    ]
        
    var dateFormatter : DateFormatter = {
        var df = DateFormatter()
        df.dateFormat = "dd-MM"
        return df
    }()
    
    var timeFormatter : DateFormatter = {
        var df = DateFormatter()
        df.dateFormat = "HH:mm"
        return df
    }()
    
}

extension GateTimesViewController{
    enum MyStrings:String{
        case title = "_Title"
        case todayButton = "_TodayButton"
        case tomorrowButton = "_TomorrowButton"
        case closingTime = "_ClosingTime"
        case openingTime = "_OpeningTime"
        case alertHeading = "_AlertHeading"
        case alertText = "_AlertText"
        case alertOkButton = "_AlertOkButton"
        case alertRepeatButton = "_AlertRepeatButton"
        case infoText = "_InfoText"
        
        var locString : String {
            getLocalizedString(for: self.rawValue, viewType: EtoshaViews.gateTimesView)
        }
    }
    
}
extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        
        return ceil(boundingBox.height)
    }
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        
        return ceil(boundingBox.width)
    }
}
