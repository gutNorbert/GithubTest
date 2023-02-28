//
//  ReusableView.swift
//  GithubTest
//
//  Created by Gutpinter Norbert on 1/30/23.
//

import Foundation

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
