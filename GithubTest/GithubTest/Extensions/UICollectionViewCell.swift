//
//  UICollectionViewCell.swift
//  GithubTest
//
//  Created by Gutpinter Norbert on 1/30/23.
//

import UIKit

extension UICollectionViewCell: ReusableView {
    static var nibName: String {
        return String(describing: self)
    }
}
