//
//  SettingsViewController.swift
//  Etoscha
//
//  Created by Björn Roxin on 28.09.21.
//

import UIKit

final class SettingsViewController: UITableViewController{
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = Appearance.backgroundColor
        setupDefaultNavBar()
        addSingleTitleToNavBar(title: MyStrings.title.locString)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "setting-reuse-identifier")
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = Appearance.backgroundColor
    }
    
    let menu : [MenuOptions] = [.howTo,.review,.webpage,.share]
    
    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
        let menuOption = menu[indexPath.row]
        switch  menuOption{
        case .howTo: callHowTo()
        case .review: writeReview()
        case .share: share()
        case .webpage: openWebpage()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "setting-reuse-identifier", for: indexPath)
        cell.backgroundColor = Appearance.backgroundColor
        let nameAttributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: Appearance.black,
            .font: UIFontMetrics(forTextStyle: .title3).scaledFont(for: UIFont(name: Appearance.regular, size: 18)!),
        ]
        var displayedString = ""
        let menuOption = menu[indexPath.row]
    
        switch menuOption {
        case .howTo: displayedString = MenuOptions.howTo.locStringExtension
        case .review: displayedString = MenuOptions.review.locStringExtension
        case .share: displayedString = MenuOptions.share.locStringExtension
        case .webpage: displayedString = MenuOptions.webpage.locStringExtension
        }
        
        let attributedString = NSAttributedString(string: displayedString, attributes: nameAttributes)
        cell.textLabel?.attributedText = attributedString
        cell.backgroundColor = Appearance.primaryColor.withAlphaComponent(0.05)
        return cell
    }

    // MARK: - Actions

    private let productURL = URL(string: "https://apps.apple.com/us/app/etosha-app/id1582052099")!
    private let webpegeURL = URL(string: "http://www.etosha-app.com")!

    private func callHowTo(){
        let welcomeVC = WelcomeViewController()
        navigationController?.pushViewController(welcomeVC, animated: true)
    }
    
    private func openWebpage(){
        UIApplication.shared.open(webpegeURL)
    }
    
    private func writeReview() {
      //1
      var components = URLComponents(url: productURL, resolvingAgainstBaseURL: false)
      
      //2
      components?.queryItems = [
        URLQueryItem(name: "action", value: "write-review")
      ]
      
      //3
      guard let writeReviewURL = components?.url else {
        return
      }
      
      // 4
      UIApplication.shared.open(writeReviewURL)
      
    }

    private func share() {
      // 1.
      let activityViewController = UIActivityViewController(
        activityItems: [productURL],
        applicationActivities: nil)

      // 2.
      present(activityViewController, animated: true, completion: nil)
    }
  }

enum MenuOptions: CaseIterable{
    case review
    case share
    case howTo
    case webpage
    
    var locStringExtension : String {
        var suffix = ""
        switch self {
        case .share: suffix =  "_share"
        case .review: suffix = "_review"
        case .howTo: suffix = "_howTo"
        case .webpage: suffix = "_webpage"
        }
        return getLocalizedString(for: suffix, viewType: EtoshaViews.settingsView)
    }
}

extension SettingsViewController{
    enum MyStrings:String{
        case title = "_title"
        
        var locString : String {
            getLocalizedString(for: self.rawValue, viewType: EtoshaViews.settingsView)
        }
    }
    
}
