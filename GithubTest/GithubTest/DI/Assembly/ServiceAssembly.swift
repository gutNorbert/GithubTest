//
//  ServiceAssembly.swift
//  GithubTest
//
//  Created by Gutpinter Norbert on 1/30/23.
//

import Foundation
import Swinject

class ServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(APIClient.self) { _ in HTTPClient() }
        
        container.register(SearchServiceable.self) { r in SearchService(apiClient: r.resolve(APIClient.self)!) } }
}
