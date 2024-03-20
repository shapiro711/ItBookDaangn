//
//  SearchViewController.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/16/24.
//

import UIKit

/**
 책 검색 화면 ViewController
 
 - Note: -
 - Date: 2023. 03. 16
 - Authors: 김도형
 */

final class SearchViewController: UIViewController {
    //MARK: - Property
    private let collectionViewDataSource = SearchCollectionViewDataSource()
    private let searchBookRepository: BookSearchable
    private var isDataLoading: Bool = false
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "책을 검색해주세요"
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.style = .large
        indicatorView.color = .systemOrange
        return indicatorView
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionVivew()
    }
    
    //MARK: - Initializer
    init(searchBookRepository: BookSearchable) {
         self.searchBookRepository = searchBookRepository
         super.init(nibName: nil, bundle: nil)
     }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionVivew() {
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = self
        collectionView.register(SearchBookCollectionViewCell.self, forCellWithReuseIdentifier: SearchBookCollectionViewCell.reuseIdentifier)
    }
    
    //MARK: - Routing
    private func moveToDetail(identifier: String) {
        let dependency = DetailBookDIContainer.Dependency(isbn13Identifier: identifier)
        let diContainer = DetailBookDIContainer(dependency: dependency)
        let detailViewController = diContainer.makeViewController()
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

//MARK: - Networking
extension SearchViewController {
    private func search(with keyword: String?) {
        guard let keyword = keyword, !keyword.isEmpty else { return }
        
        startDataLoading()
        
        searchBookRepository.searchBooks(query: keyword) { [weak self] result in
            DispatchQueue.main.async {
                self?.stopDataLoading()
                
                switch result {
                case .success(let data):
                    self?.handleSearchResult(data)
                case .failure(let error):
                    self?.handleSearchErrorResult(error)
                }
            }
        }
    }
    
    private func handleSearchResult(_ data: [BookSearchResponse.Book]) {
        guard !data.isEmpty else { return }
        
        if searchBookRepository.pageInformation.currentPage == 1 {
            collectionViewDataSource.setupData(by: data.compactMap(SearchBookModel.makeSearchBookModel(by:)))
        } else {
            collectionViewDataSource.appendData(by: data.compactMap(SearchBookModel.makeSearchBookModel(by:)))
        }
        collectionView.reloadData()
    }
    
    private func handleSearchErrorResult(_ error: Error) {
        if let pagerror = error as? PageError,
           pagerror == .endPage {
            return 
        }
        
        let message = error.localizedDescription
        ErrorAlert.show(from: self, message: message)
    }
    
    private func startDataLoading() {
        isDataLoading = true
        indicator.startAnimating()
    }

    private func stopDataLoading() {
        isDataLoading = false
        indicator.stopAnimating()
    }
}

//MARK: - SetupUI
extension SearchViewController {
    private func setupUI() {
        setupViewStyle()
        buildHierarachy()
        setupConstraint()
    }
    
    private func setupViewStyle() {
        view.backgroundColor = .systemBackground
        title = "검색"
    }
    
    private func buildHierarachy() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        view.addSubview(indicator)
    }
    
    private func setupConstraint() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            //SearchBar constraints
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            //CollectionView constraints
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            //Indicator constraints
            indicator.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor)
        ])
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBookRepository.resetPage()
        collectionViewDataSource.resetData()
        search(with: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let identifier = collectionViewDataSource.generateIdentifier(by: indexPath)
        moveToDetail(identifier: identifier)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - frameHeight && !isDataLoading {
            guard let currentQuery = searchBar.text else { return }
            search(with: currentQuery)
        }
    }
}
