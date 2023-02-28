//
//  ViewAssembly.swift
//  GithubTest
//
//  Created by Gutpinter Norbert on 1/31/23.
//

import Foundation
import Swinject

class ViewAssembly: Assembly {
    func assemble(container: Container) {
        container.register(RepositorySearchViewProtocol.self) { r in RepositorySearchView(viewModel: r.resolve(RepositorySearchViewModel.self)!)}
    }
}
