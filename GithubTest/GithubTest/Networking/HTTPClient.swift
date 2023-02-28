//
//  HTTPClient.swift
//  GithubTest
//
//  Created by Gutpinter Norbert on 1/29/23.
//

import Foundation
import Combine

protocol APIClient: AnyObject {
    func sendRequest<T: Decodable>(endpoint: Endpoint,
                                   responseModel: T.Type,
                                   queries: [URLQueryItem]?) -> Future<T, RequestError>
}

final class HTTPClient: APIClient {
    private var cancellables = Set<AnyCancellable>()
    private let jsonDecoder = JSONDecoder()
    
    func sendRequest<T: Decodable>(endpoint: Endpoint,
                                   responseModel: T.Type,
                                   queries: [URLQueryItem]? = nil) -> Future<T, RequestError> {
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return Future<T, RequestError> { [weak self] promise in
            guard let url = self?.setupURL(endpoint: endpoint, queries: queries),
                  let self = self
            else { return promise(.failure(RequestError.invalidURL)) }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse
                    else { throw RequestError.responseError }
                    
                    switch httpResponse.statusCode {
                    case 200...299:
                        return data
                    default:
                        throw RequestError.badResponse(statusCode: httpResponse.statusCode)
                    }
                }
                .decode(type: T.self, decoder: self.jsonDecoder)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                    promise(.failure(.decode)) },
                      receiveValue: { promise(.success($0)) })
                .store(in: &self.cancellables)
        }
    }
    
    
    private func setupURL(endpoint: Endpoint,
                          queries: [URLQueryItem]? = nil) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        
        if let queries {
            urlComponents.queryItems = queries
        }
        
        return urlComponents.url
    }
}
