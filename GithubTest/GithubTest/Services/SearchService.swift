//
//  SearchService.swift
//  GithubTest
//
//  Created by Gutpinter Norbert on 1/29/23.
//

import Foundation
import Combine
import Swinject

protocol SearchServiceable {
    func searchRepository(query: String) -> Future<RepositorySearch, RequestError>
}

struct SearchService: SearchServiceable {
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func searchRepository(query: String) -> Future<RepositorySearch, RequestError> {
        return apiClient.sendRequest(endpoint: SearchEndpoints.repository,
                                     responseModel: RepositorySearch.self,
                                     queries: [URLQueryItem(name: "q", value: query)])
    }
    
}

