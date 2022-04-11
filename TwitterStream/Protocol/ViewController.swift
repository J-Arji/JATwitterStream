//
//  ViewController.swift
//  TwitterStream
//
//  Created by javad Arji on 4/9/22.
//

import UIKit

/**
 Default Alert for  App. Usage is same as UIKit AlertController.

*/

protocol AlertDelegate: AnyObject {
    func showErrorAlert(title: String, message: String?)
}



extension AlertDelegate where Self: UIViewController {
    func showErrorAlert(title: String = "Error",message: String?) {
        
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
        })
    
        //Add OK and Cancel button to an Alert object
        dialogMessage.addAction(ok)
        // Present alert message to user
        present(dialogMessage, animated: true, completion: nil)
    }
}


extension UIViewController: AlertDelegate {}




