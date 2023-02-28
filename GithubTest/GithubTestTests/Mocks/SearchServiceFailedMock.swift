//
//  SearchServiceFailedMock.swift
//  GithubTestTests
//
//  Created by Gutpinter Norbert on 2/28/23.
//

import Foundation

import Foundation
@testable import GithubTest
import Combine

final class SearchServiceFailedMock: SearchServiceable, Mockable  {
    func searchRepository(query: String) -> Future<GithubTest.RepositorySearch, GithubTest.RequestError> {
        return Future<GithubTest.RepositorySearch, GithubTest.RequestError> { promise in
            return promise(.failure(.badResponse(statusCode: 400)))
        }
    }
}
