//
//  ViewModelAssembly.swift
//  GithubTest
//
//  Created by Gutpinter Norbert on 1/31/23.
//

import Foundation
import Swinject

class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(RepositorySearchViewModel.self) { r in RepositorySearchViewModelImpl(searchServiceable: r.resolve(SearchServiceable.self)!)}
    }
}
