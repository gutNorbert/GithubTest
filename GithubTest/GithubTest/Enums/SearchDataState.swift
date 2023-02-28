//
//  SearchDataState.swift
//  GithubTest
//
//  Created by Gutpinter Norbert on 1/31/23.
//

import Foundation

enum SearchDataState {

    // MARK: - Cases
    
    case loading
    case data([Repository])
    case error(RequestError)

    // MARK: - Properties
    
    var isLoading: Bool {
        switch self {
        case .loading:
            return true
        case .data, .error:
            return false
        }
    }
    
    var repositoryData: [Repository] {
        switch self {
        case .data(let repositoryData):
            return repositoryData
        case .error,
             .loading:
            return []
        }
    }
    
    var requestError: RequestError? {
        switch self {
        case .error(let requestError):
            return requestError
        case .data,
             .loading:
            return nil
        }
    }

}
