//
//  ContactNumbersViewController.swift
//  Etoscha
//
//  Created by Björn Roxin on 26.05.21.
//

import UIKit

class ContactNumbersViewController: UITableViewController {

    private var data : [TelefoneEntry] {
        var returnedList = [TelefoneEntry(name: MyStrings.police.locString, number: "061-10 111"),
                            TelefoneEntry(name: "Aeromed", number: "061-249 777"),
                            TelefoneEntry(name: "MedRescue", number: "061-230 505")
        ]
        Accommodations.allCases.forEach({ accom in
            returnedList.append(TelefoneEntry(name: accom.rawValue, number: accom.telephone))
        })
        return returnedList
    }
    
    private func makeCall(indexPath: IndexPath){
        AppUtility.makeCall(to: data[indexPath.row].number)
    }
    override func loadView() {
        super.loadView()
        view.backgroundColor = Appearance.backgroundColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultNavBar()
        addSingleTitleToNavBar(title: MyStrings.heading.locString)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TelefoneEntryCell.self, forCellReuseIdentifier: TelefoneEntryCell.reuseIdentifer)
        // Do any additional setup after loading the view.
    }
}

extension ContactNumbersViewController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: TelefoneEntryCell.reuseIdentifer, for: indexPath) as! TelefoneEntryCell
        cell.backgroundColor = Appearance.backgroundColor
        cell.phoneBookDelegate = self
        cell.configure(with: data[indexPath.row].name, tel: data[indexPath.row].number, index: indexPath)
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2{
            cell.configure(with: data[indexPath.row].name, tel: data[indexPath.row].number, color: Appearance.secondaryColor, index: indexPath)
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.width*0.15
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal,
                                        title: MyStrings.call.locString) { [weak self] (action, view, completionHandler) in
                                            self!.makeCall(indexPath: indexPath)
                                            completionHandler(true)
        }
        action.backgroundColor = Appearance.primaryColor
        return UISwipeActionsConfiguration(actions: [action])
    }
}

extension ContactNumbersViewController : PhoneBookDelegate {
    func doubleClickEntry(for index: IndexPath) {
        makeCall(indexPath: index)
    }
}

extension ContactNumbersViewController {
    enum MyStrings : String {
        case police = "_police"
        case heading = "_heading"
        case call = "_call"
        var locString : String {
            getLocalizedString(for: self.rawValue, viewType: EtoshaViews.contactNumberView)
        }
    }
}

struct TelefoneEntry {
    var name : String
    var number : String
}
