//
//  FieldNoteViewController.swift
//  Etoscha
//
//  Created by Björn Roxin on 16.07.21.
//

import UIKit
import FirebaseAnalytics

class FieldNoteViewController: UIViewController{

    //MARK: Data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var index : Int? {
        didSet{
            fetchFieldNote()
        }
    }
    var fieldNote : FieldNote? {
        didSet{
            setTitle()
            setText()
        }
    }
    
    //MARK: Views
    private var scrollView = UIScrollView()
    private var containerView = UIView()
    private var titleView = UITextView()
    private var textView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Appearance.backgroundColor
        setupViews()
        setTitle()
        setText()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Analytics.logEvent(MyAnalyticsEvents.modifiedFieldNote.rawValue, parameters: [MyAnalyticsParameters.editMode.rawValue: EditMode.edit.rawValue])
    }
    
    
    private func setTitle(){
        if fieldNote?.heading != nil {
            titleView.attributedText = NSAttributedString(string: fieldNote!.heading!, attributes: getTitleAtrributes(with: Appearance.black))
        }
    }
    
    private func setText(){
        if fieldNote?.text != nil {
            textView.attributedText = NSAttributedString(string: fieldNote!.text!, attributes: getParagraphAtrributes(with: Appearance.gray))
        }
    }
    
    private func setupViews(){
        titleView.delegate = self
        titleView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleView)
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Appearance.spacing),
            titleView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding),
            titleView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Appearance.padding),
            titleView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1)
        ])
        titleView.attributedText = NSAttributedString(string: MyString.headingPlaceholder.locString, attributes: getTitleAtrributes(with: Appearance.lightGray))
        titleView.textColor = Appearance.lightGray
        titleView.backgroundColor = Appearance.backgroundColor
        
        textView.delegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -Appearance.spacing),
            textView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding),
            textView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Appearance.padding),
            //textView.heightAnchor.constraint(equalToConstant: NSAttributedString(string: fieldNote?.text ?? "Some Title").height(withConstrainedWidth: self.view.frame.width)*2),
            textView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -Appearance.spacing),
        ])
        textView.attributedText = NSAttributedString(string: MyString.textPlaceholder.locString, attributes: getParagraphAtrributes(with: Appearance.lightGray))
        textView.backgroundColor = Appearance.backgroundColor
    }
    
    private func saveData(){
        // Copy data to fieldNoet
        fieldNote?.heading = titleView.text
        fieldNote?.text = textView.text
        fieldNote?.dateAdded = Date()
        
        //Delete Entry if text didnt change
        if fieldNote?.heading == MyString.headingPlaceholder.locString || fieldNote?.text == MyString.textPlaceholder.locString {
            self.context.delete(fieldNote!)
        }
        
        //Save data
        do {
            try self.context.save()
        }catch{}
       
    }
    private func fetchFieldNote(){
        do {
            if index != nil {
                fieldNote = try context.fetch(FieldNote.fetchRequest())[index!] as FieldNote
            }
        }catch{}
    }
}
extension FieldNoteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == MyString.textPlaceholder.locString{
            textView.text = nil
            textView.typingAttributes = getParagraphAtrributes(with: Appearance.black)
        }
        if textView.text == MyString.headingPlaceholder.locString{
            textView.text = nil
            textView.typingAttributes = getTitleAtrributes(with: Appearance.black)
        }
    }
    
    private func getParagraphAtrributes(with color: UIColor)-> [NSAttributedString.Key: Any] {
        let textParagraphstyle = NSMutableParagraphStyle()
        textParagraphstyle.alignment = .justified
        let textFont = UIFont(name: Appearance.regular, size: 16)
        return [
            .foregroundColor: color,
            .font: UIFontMetrics(forTextStyle: .body).scaledFont(for: textFont!),
            .paragraphStyle: textParagraphstyle
        ]
    }
    private func getTitleAtrributes(with color: UIColor)-> [NSAttributedString.Key: Any] {
        let paragraphstyle = NSMutableParagraphStyle()
        paragraphstyle.alignment = .left
        let font = UIFont(name: Appearance.semiBold, size: 20)
        return [
            .foregroundColor: color,
            .font: UIFontMetrics(forTextStyle: .title1).scaledFont(for: font!),
            .paragraphStyle: paragraphstyle
        ]
    }
}

extension FieldNoteViewController{
    enum MyString:String{
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
