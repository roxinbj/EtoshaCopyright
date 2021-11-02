//
//  ViewSetupUtilities.swift
//  Etoscha
//
//  Created by Björn Roxin on 04.07.21.
//

import UIKit

func setupScrollView(for scrollView: UIScrollView, parent: UIView){
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.isDirectionalLockEnabled = true
    parent.addSubview(scrollView)
    NSLayoutConstraint.activate([
        scrollView.topAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.topAnchor),
        scrollView.leadingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.leadingAnchor),
        scrollView.widthAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.widthAnchor),
        scrollView.heightAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.heightAnchor)
    ])
}

func setupLorizontalLine(for line: UIView, topAnchor: UIView, mainView: UIView, parentView: UIView){
    line.translatesAutoresizingMaskIntoConstraints = false
    parentView.addSubview(line)
    NSLayoutConstraint.activate([
        line.topAnchor.constraint(equalTo: topAnchor.bottomAnchor,constant: Appearance.spacing),
        line.centerXAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.centerXAnchor, constant: 0),
        line.widthAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.widthAnchor, multiplier: Appearance.horizontalLineWidthRatio),
        line.heightAnchor.constraint(equalToConstant: Appearance.horizontalLineWidth)
    ])
    line.backgroundColor = Appearance.primaryColor
}

//TODO Move as utility for all views
func setupParagraph(for view: UILabel, topAnchor: UIView, with text: String?, mainView: UIView, parentView: UIView){
    view.translatesAutoresizingMaskIntoConstraints = false
    parentView.addSubview(view)
    var spacing = Appearance.spacing
    if text == nil {
        spacing = 0
    }
    NSLayoutConstraint.activate([
        view.topAnchor.constraint(equalTo: topAnchor.bottomAnchor, constant: spacing),
        view.leadingAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.leadingAnchor,constant: Appearance.padding),
        view.trailingAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.trailingAnchor, constant: -Appearance.padding),
    ])
    let textAttribute : [NSAttributedString.Key: Any] =
        [
            .foregroundColor: Appearance.black,
            .font: UIFont(name: Appearance.regular, size: 16)!,
            .paragraphStyle: Appearance.paragraphStyle
        ]
    view.attributedText = NSAttributedString(string: text ?? "", attributes: textAttribute)
    view.numberOfLines = 0
    view.textAlignment = .justified
}

func setupParagraph(for view: UILabel, topAnchor: UIView, with text: NSAttributedString, mainView: UIView, parentView: UIView){
    view.translatesAutoresizingMaskIntoConstraints = false
    parentView.addSubview(view)
    NSLayoutConstraint.activate([
        view.topAnchor.constraint(equalTo: topAnchor.bottomAnchor, constant: Appearance.spacing),
        view.leadingAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.leadingAnchor,constant: Appearance.padding),
        view.trailingAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.trailingAnchor, constant: -Appearance.padding),
    ])
    view.attributedText = text
    view.numberOfLines = 0
    view.textAlignment = .justified
}

func setupHeading(for view: UILabel, topAnchor: UIView, with text: String?, mainView: UIView, parentView: UIView, alignment: NSTextAlignment = .left){
    let paragraphstyle = NSMutableParagraphStyle()
    paragraphstyle.alignment = alignment
    paragraphstyle.hyphenationFactor = 1
    view.translatesAutoresizingMaskIntoConstraints = false
    parentView.addSubview(view)
    var spacing = Appearance.spacing
    if text == nil {
        spacing = 0
    }
    NSLayoutConstraint.activate([
        view.topAnchor.constraint(equalTo: topAnchor.safeAreaLayoutGuide.bottomAnchor, constant: spacing),
        view.leadingAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.leadingAnchor, constant: Appearance.padding),
        view.trailingAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.trailingAnchor, constant: -Appearance.padding),
    ])
    view.attributedText = NSAttributedString(string: text ?? "", attributes: Appearance.subheadingAttributes)
    view.numberOfLines = 0
    view.sizeToFit()
    view.textAlignment = alignment
}

func getLocalizedString(for string: String, viewType: EtoshaViews)->String{
    return NSLocalizedString(viewType.rawValue+string, tableName: "Texts", bundle: .main, value: ErrorHandler.localizedStringNotFound, comment: "Loc String")
}
