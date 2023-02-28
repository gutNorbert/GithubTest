//
//  ServiceAssembly.swift
//  GithubTestTests
//
//  Created by Gutpinter Norbert on 2/2/23.
//

import Foundation
import Swinject
@testable import GithubTest


class ServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SearchServiceable.self, name: Assembler.SearchServiceMockTypes.searchServiceSuccess.rawValue) { _ in SearchServiceSuccessMock() }
        container.register(SearchServiceable.self, name: Assembler.SearchServiceMockTypes.searchServiceFailure.rawValue) { _ in SearchServiceFailedMock() }
    }
}
