//
//  Coordinator.swift
//  GithubTest
//
//  Created by Gutpinter Norbert on 1/29/23.
//

import UIKit

class Coordinator: NSObject, UINavigationControllerDelegate {
    
    var didFinish: ((Coordinator) -> Void)?
    
    var childCoordinators: [Coordinator] = []

    func start() {}
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {}
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {}
    
    func pushCoordinator(_ coordinator: Coordinator) {
        coordinator.didFinish = { [weak self] (coordinator) in
            self?.popCoordinator(coordinator)
        }
        
        coordinator.start()
        
        childCoordinators.append(coordinator)
    }
    
    func popCoordinator(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }

}
