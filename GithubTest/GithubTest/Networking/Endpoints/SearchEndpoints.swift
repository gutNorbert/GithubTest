//
//  SearchEndpoints.swift
//  GithubTest
//
//  Created by Gutpinter Norbert on 1/29/23.
//

import Foundation

enum SearchEndpoints {
    case repository
}

extension SearchEndpoints: Endpoint {
    var header: [String : String]? {
        return [ "Accept": "application/vnd.github+json"] }
    
    var path: String {
        switch self {
        case .repository:
            return "/search/repositories"
        }
    }

    var method: RequestMethod {
        switch self {
        case .repository:
            return .get
        }
    }
}
