//
//  FieldNotesTableViewController.swift
//  Etoscha
//
//  Created by Björn Roxin on 15.07.21.
//

import UIKit
import FirebaseAnalytics

class FieldNotesTableViewController: UIViewController {

    //MARK: Views
    private let addButton = UIButton()
    private let tableView = UITableView()
    
    //MARK: Data
    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var fieldNotes : [FieldNote]?
    
    
    @objc private func addFieldNote(_ sender: Any){
        Analytics.logEvent(MyAnalyticsEvents.modifiedFieldNote.rawValue, parameters: [MyAnalyticsParameters.editMode.rawValue: EditMode.add.rawValue])
        //Create new Item
        // creat FieldNote object
        let _ = FieldNote(context: self.context)
        //Save data
        do {
            try self.context.save()
        }catch{}
        
        // refetch data
        self.fetchFieldNotes()
        
        //go to VC
        let vc = FieldNoteViewController()
        vc.index = fieldNotes!.count - 1
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc private func deleteCell(indexPath: IndexPath){
        Analytics.logEvent(MyAnalyticsEvents.modifiedFieldNote.rawValue, parameters: [MyAnalyticsParameters.editMode.rawValue: EditMode.remove.rawValue])

        // creat FieldNote object
        let toBeRemovedNote = fieldNotes![indexPath.row]
        
        // delete fieldNote
        self.context.delete(toBeRemovedNote)
        
        //Save data
        do {
            try self.context.save()
        }catch{}
        
        // refetch data
        self.fetchFieldNotes()
        
    }
    
    private func fetchFieldNotes(){
        do {
            fieldNotes = try context.fetch(FieldNote.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }catch{}
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFieldNotes()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSingleTitleToNavBar(title: MyString.Title.locString)
        addIconsToNavBarRight(icons: [UIImage(named: "plus-solid")!.withTintColor(Appearance.primaryColor)], targets: [#selector(addFieldNote(_:))])
        setupTableView()
        view.backgroundColor = Appearance.backgroundColor
        tableView.register(FieldNoteTableViewCell.self, forCellReuseIdentifier: FieldNoteTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        fetchFieldNotes()
        self.view.bringSubviewToFront(addButton)
    }
    
    private func setupTableView(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Appearance.spacing),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: -Appearance.padding)
        ])
        tableView.backgroundColor = Appearance.backgroundColor
        tableView.separatorStyle = .none
    }

    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: MyString.delete.locString) { [weak self] (action, view, completionHandler) in
                                            self!.deleteCell(indexPath: indexPath)
                                            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
extension FieldNotesTableViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fieldNotes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FieldNoteTableViewCell.reuseIdentifier, for: indexPath) as! FieldNoteTableViewCell
        cell.configure(heading: fieldNotes![indexPath.row].heading ?? "Empty Heading", text: fieldNotes![indexPath.row].text ?? "Empty Text", date: Date())
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = FieldNoteViewController()
        vc.index = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension FieldNotesTableViewController {
    enum MyString:String {
        case Title = "Title"
        case edit = "edit"
        case delete = "delete"
        case add = "add"
        case done = "done"
        case cancel = "cancel"
        case editHeading = "editHeading"
        case addHeading = "addHeading"
        case editMessage = "editMessage"
        case addMessage = "addMessage"
        case headingPlaceholder = "headingPlaceholder"
        case textPlaceholder = "textPlaceholder"
        
        var locString : String {
            getLocalizedString(for: ("_" + self.rawValue), viewType: EtoshaViews.fieldNotesView)
        }
    }
}
