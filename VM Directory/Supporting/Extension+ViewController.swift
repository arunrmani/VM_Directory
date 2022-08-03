//
//  Extension+ViewController.swift
//  NY Articles
//
//  Created by Safe City Mac 001 on 23/12/2021.
//

import Foundation
import UIKit

extension UIViewController{

// MARK: - Alert Call

    func showAlert(title: String, message: String, alertStyle:UIAlertController.Style, actionTitles:[String], actionStyles:[UIAlertAction.Style], actions: [((UIAlertAction) -> Void)]) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        for(index, indexTitle) in actionTitles.enumerated(){
            let action = UIAlertAction(title: indexTitle, style: actionStyles[index], handler: actions[index])
            alertController.addAction(action)
        }
        self.present(alertController, animated: true)
    }
    func showAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
}
