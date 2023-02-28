//
//  RepositorySearchView.swift
//  GithubTest
//
//  Created by Gutpinter Norbert on 1/29/23.
//

import UIKit
import Swinject
import Combine

protocol RepositorySearchViewProtocol: UIViewController {
    func startLoading()
    var showWebPage: ((URL) -> Void)? { get set }
}

class RepositorySearchViewDiffableDataSource: UICollectionViewDiffableDataSource<String?, Repository> {}


final class RepositorySearchView: UIViewController, RepositorySearchViewProtocol {
    // MARK: Outlets
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.backgroundColor = .clear
            
            let cardView = UINib(nibName: RepositoryCardViewCell.nibName, bundle: .main)
            collectionView.register(cardView, forCellWithReuseIdentifier: RepositoryCardViewCell.nibName)
        }
    }
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet var mainView: UIView! {
        didSet {
            mainView.backgroundColor = .purple251b37
        }
    }
    
    // MARK: Variables
    private var viewModel: RepositorySearchViewModel
    private var cancellables = Set<AnyCancellable>()
    @Published private var keyStroke: String = ""
    var showWebPage: ((URL) -> Void)?
    
    
    //MARK: Initializers
    
    init(viewModel: RepositorySearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "RepositorySearchView", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.start()
        setupObservers()
        bind(to: viewModel)
    }
    
    // MARK: Functions
    
    func startLoading() {
        view.showLoader()
    }
    
    private func bind(to viewModel: RepositorySearchViewModel) {
        viewModel.loadingPublisher
            .sink(receiveValue: { [weak self] in
                $0 ? self?.startLoading() : self?.view.dismissLoader()})
            .store(in: &cancellables)
        
        viewModel.errorPublisher
            .sink { [weak self] error in
                switch error {
                case .responseError, .invalidURL, .decode:
                    self?.presentAlert(of: .unknown)
                case .badResponse(statusCode: let statusCode):
                    switch statusCode {
                    case 422:
                        self?.presentAlert(of: .spammed)
                    case 503:
                        self?.presentAlert(of: .unavailable)
                    default:
                        self?.presentAlert(of: .unknown)
                    }
                }
            }.store(in: &cancellables)
    }
    
    private func setDataSource() {
        viewModel.diffableDataSource = RepositorySearchViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, model in
            let cell: RepositoryCardViewCell = collectionView.dequeueReusableCell(for: indexPath)
            
            cell.configure(with: model)
            
            return cell
        })
        
       
    }
    
    private func setupObservers() {
        $keyStroke
            .receive(on: RunLoop.main)
            .sink { [weak self] keywordValue in
                self?.viewModel.keyWordSearch.send(keywordValue)
            }.store(in: &cancellables)
        
        setDataSource()
    }
}

// MARK: CollectionView

extension RepositorySearchView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let repository = viewModel.diffableDataSource?.itemIdentifier(for: indexPath) {
            showWebPage?(repository.htmlUrl)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 20, height: 200.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
}

// MARK: SearchBar

extension RepositorySearchView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.keyStroke = searchText
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.keyStroke = ""
    }
}
