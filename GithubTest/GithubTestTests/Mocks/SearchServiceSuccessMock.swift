//
//  SearchServiceSuccessMock.swift
//  GithubTestTests
//
//  Created by Gutpinter Norbert on 2/2/23.
//

import Foundation
@testable import GithubTest
import Combine

final class SearchServiceSuccessMock: SearchServiceable, Mockable  {
    func searchRepository(query: String) -> Future<GithubTest.RepositorySearch, GithubTest.RequestError> {
        return Future<GithubTest.RepositorySearch, GithubTest.RequestError> {[weak self] promise in
            return promise(.success((self?.loadJSON(filename: "SearchRepository", type: RepositorySearch.self))!))
        }
    }
}
