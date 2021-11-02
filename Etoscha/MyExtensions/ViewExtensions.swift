//
//  ViewExtensions.swift
//  Etoscha
//
//  Created by Björn Roxin on 07.04.21.
//

import UIKit

func getStackView(for elements: [UIView], with axis: NSLayoutConstraint.Axis, spacing: CGFloat) -> UIStackView {
    let stackview = UIStackView(arrangedSubviews: elements)
    stackview.axis = axis
    stackview.distribution = .fillEqually
    stackview.alignment = .fill
    stackview.spacing = spacing
    stackview.translatesAutoresizingMaskIntoConstraints = false
    return stackview
}
