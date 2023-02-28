//
//  WhiteSearchBar.swift
//  GithubTest
//
//  Created by Gutpinter Norbert on 2/1/23.
//

import UIKit

class WhiteSearchBar: UISearchBar, UISearchBarDelegate {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupInnerTextfield()
        setupBorder()
        setupTransparency()
        
        delegate = self
    }
    
    private func setupBorder() {
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 30
    }
    
    private func setupTransparency() {
        self.tintColor = .white
        self.isTranslucent = true
        self.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    }
    
    private func setupInnerTextfield() {
        if let textfield = self.value(forKey: "searchField") as? UITextField {
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
            textfield.textColor = .white
            
            if let leftView = textfield.leftView as? UIImageView {
                leftView.tintColor = UIColor.white
            }
            
            self.searchTextField.backgroundColor = .clear
        }
    }
}
