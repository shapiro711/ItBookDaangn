//
//  DetailViewController.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/18/24.
//

import UIKit

/**
 책 상세 화면 ViewController
 
 - Note: -
 - Date: 2023. 03. 18
 - Authors: 김도형
 */

final class DetailViewController: UIViewController {
    //MARK: - Property
    private let collectionViewDataSource = DetailCollectionViewDataSource()
    private let repository: BookDetailFetchhable
    private let identifier: String
    
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
        fetchBookDetail()
    }
    
    //MARK: - Initializer
    init(repository: BookDetailFetchhable, identifier: String) {
        self.repository = repository
        self.identifier = identifier
        super.init(nibName: nil, bundle: nil)
     }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionVivew() {
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = self
        registerCell()
    }
    
    private func registerCell() {
        collectionView.register(DetailBookImageCollectionViewCell.self, forCellWithReuseIdentifier: DetailBookImageCollectionViewCell.reuseIdentifier)
        collectionView.register(DetailBookTitleCollectionViewCell.self, forCellWithReuseIdentifier: DetailBookTitleCollectionViewCell.reuseIdentifier)
        collectionView.register(DetailBookInformationCollectionViewCell.self, forCellWithReuseIdentifier: DetailBookInformationCollectionViewCell.reuseIdentifier)
        collectionView.register(DetailBookDescriptionCollectionViewCell.self, forCellWithReuseIdentifier: DetailBookDescriptionCollectionViewCell.reuseIdentifier)
    }
}

//MARK: - Networking
extension DetailViewController {
    func fetchBookDetail() {
        repository.fetchBookDetails(isbn13Identifier: identifier) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.handleSearchResult(data)
                case .failure:
                    break
                }
            }
        }
    }
    
    private func handleSearchResult(_ data: BookDetailResponse) {
        collectionViewDataSource.setupData(by: DetailBookModel.from(bookDetailResponse: data))
        collectionView.reloadData()
    }
}

//MARK: - SetupUI
extension DetailViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
        buildHierarachy()
        setupConstraint()
    }
    
    private func buildHierarachy() {
        view.addSubview(collectionView)
    }
    
    private func setupConstraint() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            //CollectionView constraints
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cellType = CellType(rawValue: indexPath.row) else {
            return .zero
        }
        
        let width = collectionView.frame.width
        
        switch cellType {
        case .image:
            return CGSize(width: width, height: 300)
        case .title:
            return CGSize(width: width, height: 50)
        case .information:
            return CGSize(width: width, height: 130)
        case .description:
            return CGSize(width: width, height: 120)
        }
        
        return .zero
    }
}
