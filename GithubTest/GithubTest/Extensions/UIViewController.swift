//
//  UIViewController.swift
//  GithubTest
//
//  Created by Gutpinter Norbert on 2/1/23.
//

import UIKit

extension UIViewController {
    
    func presentAlert(of alertType: AlertTypes) {
        
        let title = "Unable to fetch repostory datas"
        let message: String
        
        switch alertType {
        case .spammed:
            message = "The server has been spammed"
        case .unavailable:
            message = "Service is currently not available"
        case .unknown:
            message = "Unknown error"
        case .emptyResponse:
            message = "Try it with a different keyword"
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}
