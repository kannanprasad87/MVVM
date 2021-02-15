//
//  UIViewController+Alert.swift
//  MVVM
//
//  Created by Kannan Prasad on 13/02/2021.
//

import UIKit

extension UIViewController {

    func showWarningAlert(message:String, actions:[UIAlertAction]?){
        showAlert(title:"Warning", message: message, actions: actions)
    }

    func showErrorAlert(message:String, actions:[UIAlertAction]?){
        showAlert(title: "Error", message: message, actions: actions)
    }

    func showAlert(title:String, message:String, actions:[UIAlertAction]?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        if actions != nil {
            for action in actions!{
                alert.addAction(action)
            }
        }

        self.present(alert, animated: true)
    }

    func okAlertAction() -> UIAlertAction{
       return UIAlertAction(title:"Ok", style: .default, handler: nil)
    }

    func dismissAnyAlertView(){
        if let alert = self.presentedViewController, alert.isKind(of: UIAlertController.self){
            self.dismiss(animated: true, completion: nil)
        }
    }
}
