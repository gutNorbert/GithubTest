//
//  RepositorySearchCoordinator.swift
//  GithubTest
//
//  Created by Gutpinter Norbert on 1/29/23.
//

import UIKit
import Swinject

class RepositorySearchCoordinator: Coordinator {
    private let navigationController = UINavigationController()
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    override func start() {
        navigationController.delegate = self
        
        let repositorySearchView = Assembler.sharedAssembler.resolver.resolve(RepositorySearchViewProtocol.self)!
        
        repositorySearchView.showWebPage = { [weak self] page in
            self?.showWebpage(for: page)
        }
        
        navigationController.pushViewController(repositorySearchView, animated: true)
    }
    
    private func showWebpage(for url: URL) {
        let webViewCoordinator = WebViewCoordinator(navigationController: navigationController, url: url)
        pushCoordinator(webViewCoordinator)
    }
    
    override func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        childCoordinators.forEach { (childCoordinator) in
            childCoordinator.navigationController(navigationController, willShow: viewController, animated: animated)
        }
    }

    override func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        childCoordinators.forEach { (childCoordinator) in
            childCoordinator.navigationController(navigationController, didShow: viewController, animated: animated)
        }
    }
}
