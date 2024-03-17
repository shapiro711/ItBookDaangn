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
    private let searchBookRepository = SearchBookRepository(networkService: NetworkService(sessionManager: SessionManager()))
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "책을 검색해주세요"
        searchBar.backgroundImage = UIImage()
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
        return indicatorView
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionVivew()
    }
    
    //MARK: - Initializer
    init() {
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
}

//MARK: - Networking
extension SearchViewController {
    private func search(with keyword: String?) {
        guard let keyword = keyword, checkSearchBarText(keyword) else { return }
        
        indicator.startAnimating()
        
        searchBookRepository.searchBooks(query: keyword) { [weak self] result in
            DispatchQueue.main.async {
                self?.indicator.stopAnimating()
                
                switch result {
                case .success(let data):
                    self?.collectionViewDataSource.setupData(by: data.compactMap(SearchBookModel.makeSearchBookModel(by:)))
                    self?.collectionView.reloadData()
                case .failure:
                    break
                }
            }
        }
    }
    
    private func checkSearchBarText(_ keyword: String?) -> Bool {
        // searchBar의 텍스트가 nil이거나 비어있는지 검사
        guard let keyword = keyword, !keyword.isEmpty else {
            return false
        }
        return true
    }
}

//MARK: - SetupUI
extension SearchViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
        buildHierarachy()
        setupConstraint()
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
            searchBar.heightAnchor.constraint(equalToConstant: 44),
            
            //CollectionView constraints
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            indicator.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor)
        ])
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(false)
        search(with: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 셀의 크기를 설정
        return CGSize(width: collectionView.frame.width, height: 140)
    }
}
