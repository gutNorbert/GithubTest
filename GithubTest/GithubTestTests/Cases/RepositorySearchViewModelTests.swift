//
//  RepositorySearchViewModelTests.swift
//  RepositorySearchViewModelTests
//
//  Created by Gutpinter Norbert on 1/28/23.
//

import XCTest
@testable import GithubTest
import Combine
import Swinject

final class RepositorySearchViewModelTests: XCTestCase {
    var sut: RepositorySearchViewModelImpl!
    var cancellables: Set<AnyCancellable>!
    
    // MARK: Setups
    
    private func setupWithSuccess() {
        let service = Assembler.sharedAssembler.resolver.resolve(SearchServiceable.self, name: Assembler.SearchServiceMockTypes.searchServiceSuccess.rawValue)!
        sut = RepositorySearchViewModelImpl(searchServiceable: service)
        cancellables = Set<AnyCancellable>()
    }
    
    private func setupWithError() {
        let service = Assembler.sharedAssembler.resolver.resolve(SearchServiceable.self, name: Assembler.SearchServiceMockTypes.searchServiceFailure.rawValue)!
        sut = RepositorySearchViewModelImpl(searchServiceable: service)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        cancellables = nil
    }
    
    // MARK: Error case
    
    func test_errorPublisher_whenHasError_emitsValue() {
        let errorPublisherExpectation = expectation(description: "ErrorPublisher expectation")
        setupWithError()
        
        sut.start()
        sut.errorPublisher
            .sink(receiveValue: { error in
                    errorPublisherExpectation.fulfill()
            })
            .store(in: &cancellables)
        
        sut.keyWordSearch.send("testKeyword")
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    // MARK: Loading case
    
    func test_loadingPublisher_whenKeywordSearched_startsLoading() {
        let loadingPublisherExpectation = expectation(description: "LoadingPublisher expectation")
        setupWithSuccess()
        
        sut.start()
        sut.loadingPublisher
            .sink(receiveValue: { loading in
                if loading {
                    loadingPublisherExpectation.fulfill()
                }
                return
            })
            .store(in: &cancellables)
        
        sut.keyWordSearch.send("testKeyword")
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    // MARK: Success case
    
    func test_dataPublisher_whenKeywordSearched_emitsCorrectLanguage() {
        let dataPublisherExpectation = expectation(description: "DataPublisher expectation")
        setupWithSuccess()
        
        sut.start()
        sut.dataPublisher
            .sink(receiveValue: { data in
                if !data.isEmpty {
                    XCTAssertEqual(data.first?.language, "C++")
                    dataPublisherExpectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        sut.keyWordSearch.send("testKeyword")
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func test_dataPublisher_whenKeywordSearched_fullNameIsAppleSwift() {
        let dataPublisherExpectation = expectation(description: "DataPublisher expectation")
        setupWithSuccess()
        
        sut.start()
        sut.dataPublisher
            .sink(receiveValue: { data in
                if !data.isEmpty {
                    XCTAssertEqual(data.first?.fullName, "apple/swift")
                    dataPublisherExpectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        sut.keyWordSearch.send("testKeyword")
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func test_dataPublisher_whenKeywordSearched_htmlURLIsValid() {
        let dataPublisherExpectation = expectation(description: "DataPublisher expectation")
        setupWithSuccess()
        
        sut.start()
        sut.dataPublisher
            .sink(receiveValue: { data in
                if !data.isEmpty {
                    XCTAssertEqual(data.first?.htmlUrl.absoluteString, "https://github.com/apple/swift")
                    dataPublisherExpectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        sut.keyWordSearch.send("testKeyword")
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func test_dataPublisher_whenKeywordSearched_descriptionIsCorrect() {
        let dataPublisherExpectation = expectation(description: "DataPublisher expectation")
        setupWithSuccess()
        
        sut.start()
        sut.dataPublisher
            .sink(receiveValue: { data in
                if !data.isEmpty {
                    XCTAssertEqual(data.first?.description, "The Swift Programming Language")
                    dataPublisherExpectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        sut.keyWordSearch.send("testKeyword")
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func test_dataPublisher_whenKeywordSearched_starsAreCorrect() {
        let dataPublisherExpectation = expectation(description: "DataPublisher expectation")
        setupWithSuccess()
        
        sut.start()
        sut.dataPublisher
            .sink(receiveValue: { data in
                if !data.isEmpty {
                    XCTAssertEqual(data.first?.stargazersCount, 61723)
                    dataPublisherExpectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        sut.keyWordSearch.send("testKeyword")
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func test_dataPublisher_whenKeywordSearched_ownerLoginIsCorrect() {
        let dataPublisherExpectation = expectation(description: "DataPublisher expectation")
        setupWithSuccess()
        
        sut.start()
        sut.dataPublisher
            .sink(receiveValue: { data in
                if !data.isEmpty {
                    XCTAssertEqual(data.first?.owner.login, "apple")
                    dataPublisherExpectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        sut.keyWordSearch.send("testKeyword")
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func test_dataPublisher_whenKeywordSearched_ownerAvatarURLIsCorrect() {
        let dataPublisherExpectation = expectation(description: "DataPublisher expectation")
        setupWithSuccess()
        
        sut.start()
        sut.dataPublisher
            .sink(receiveValue: { data in
                if !data.isEmpty {
                    XCTAssertEqual(data.first?.owner.avatarUrl.absoluteString, "https://avatars.githubusercontent.com/u/10639145?v=4")
                    dataPublisherExpectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        sut.keyWordSearch.send("testKeyword")
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    
}
