//
//  WebViewCoordinator.swift
//  GithubTest
//
//  Created by Gutpinter Norbert on 2/1/23.
//

import UIKit

class WebViewCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private let url: URL
   
    
    init(navigationController: UINavigationController,
         url: URL) {
        self.navigationController = navigationController
        self.url = url
        super.init()
    }
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    override func start() {
        navigationController.delegate = self

        let webViewController = WebViewController()
        
        webViewController.url = url

        navigationController.pushViewController(webViewController, animated: true)
    }
}
