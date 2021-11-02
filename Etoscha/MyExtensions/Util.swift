//
//  Util.swift
//  Etoscha
//
//  Created by Björn Roxin on 19.07.21.
//

import Foundation
import UIKit

fileprivate var spinnerView : UIView?

extension UIViewController{
    
    func showSpinner(){
        spinnerView = UIView(frame: self.view.bounds)
        spinnerView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = spinnerView!.center
        activityIndicator.startAnimating()
        spinnerView?.addSubview(activityIndicator)
        self.view.addSubview(spinnerView!)
        
        Timer.scheduledTimer(withTimeInterval: 20.0, repeats:false) { (t) in
            self.removeSpinner()
        }
    }
    
    func removeSpinner(){
        spinnerView?.removeFromSuperview()
        spinnerView = nil
    }
}
