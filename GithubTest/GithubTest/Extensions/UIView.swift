//
//  UIView.swift
//  GithubTest
//
//  Created by Gutpinter Norbert on 1/31/23.
//

import UIKit

extension UIView {
    func showLoader(with color: UIColor? = .white){
           let loader = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
           loader.center = self.center
           loader.style = .large
           loader.color = color
           loader.startAnimating()
           loader.tag = -888754
           self.addSubview(loader)
       }
       
       func dismissLoader() {
           self.viewWithTag(-888754)?.removeFromSuperview()
       }
}
