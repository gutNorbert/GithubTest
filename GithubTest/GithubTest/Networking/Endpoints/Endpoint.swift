//
//  Endpoint.swift
//  GithubTest
//
//  Created by Gutpinter Norbert on 1/29/23.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }

    var host: String {
        return "api.github.com"
    }
}
