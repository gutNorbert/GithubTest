//
//  RepositorySearchViewModel.swift
//  GithubTest
//
//  Created by Gutpinter Norbert on 1/31/23.
//

import UIKit
import Combine

protocol RepositorySearchViewModel: AnyObject {
    func start()
    
    var loadingPublisher: AnyPublisher<Bool, Never> { get }
    var errorPublisher: AnyPublisher<RequestError, Never> { get }
    var keyWordSearch: PassthroughSubject<String, Never> { get set }
    var diffableDataSource: RepositorySearchViewDiffableDataSource? { get set }
    var dataPublisher: AnyPublisher<[Repository], Never> { get }
    var searchDataStateSubject: PassthroughSubject<SearchDataState, Never> { get set}
}

class RepositorySearchViewModelImpl: RepositorySearchViewModel {
    
    // MARK: Variables
    private var cancellables = Set<AnyCancellable>()
    private let searchService: SearchServiceable
    var searchDataStateSubject = PassthroughSubject<SearchDataState, Never>()
    var keyWordSearch = PassthroughSubject<String, Never>()
    var diffableDataSource: RepositorySearchViewDiffableDataSource?
    private var snapshot = NSDiffableDataSourceSnapshot<String?, Repository>()
    
    var loadingPublisher: AnyPublisher<Bool, Never> {
        searchDataStateSubject
            .map { $0.isLoading }
            .eraseToAnyPublisher()
    }
    
    var dataPublisher: AnyPublisher<[Repository], Never> {
        searchDataStateSubject
            .compactMap { $0.repositoryData }
            .eraseToAnyPublisher()
    }
    
    var errorPublisher: AnyPublisher<RequestError, Never> {
        searchDataStateSubject
            .compactMap { $0.requestError }
            .eraseToAnyPublisher()
    }
    
    // MARK: Functions
    init(searchServiceable: SearchServiceable) {
        searchService = searchServiceable
    }
    
    func start() {
        handleBindings()
    }
    
    private func handleBindings() {
        observeKeyword()
        setupDataSource()
    }
    
    private func observeKeyword() {
        keyWordSearch
            .receive(on: RunLoop.main)
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .removeDuplicates()
            .filter { $0 != "" }
            .sink { [weak self] text in
                self?.searchRepository(for: text)
            }.store(in: &cancellables)
    }
    
    private func setupDataSource() {
        dataPublisher
            .sink { [weak self] repositories in
                guard let self = self,
                      self.diffableDataSource != nil else { return }
                
                self.snapshot.deleteAllItems()
                self.snapshot.appendSections([""])
                
                if repositories.isEmpty {
                    self.diffableDataSource?.apply(self.snapshot, animatingDifferences: true)
                    return
                }
                
                self.snapshot.appendItems(repositories)
                self.diffableDataSource?.apply(self.snapshot, animatingDifferences: true)
            }.store(in: &cancellables)
    }
    
    private func searchRepository(for keyword: String) {
        searchDataStateSubject.send(.loading)
        
        searchService.searchRepository(query: keyword)
            .map { $0.items }
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.searchDataStateSubject.send(.error(error))
                }
            }, receiveValue: { [weak self] repositories in
                if repositories.isEmpty {
                    self?.searchDataStateSubject.send(.error(.badResponse(statusCode: 503)))
                } else {
                    self?.searchDataStateSubject.send(.data(repositories))
                }
                
            }).store(in: &cancellables)
    }
}
