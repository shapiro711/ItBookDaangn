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
        indicatorView.style = .large
        indicatorView.color = .systemOrange
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
        collectionViewDataSource.setupDelegate(self)
        registerCell()
    }
    
    private func registerCell() {
        collectionView.register(DetailBookImageCollectionViewCell.self, forCellWithReuseIdentifier: DetailCellType.image.reuseIdentifier)
        collectionView.register(DetailBookTitleCollectionViewCell.self, forCellWithReuseIdentifier: DetailCellType.title.reuseIdentifier)
        collectionView.register(DetailBookInformationCollectionViewCell.self, forCellWithReuseIdentifier: DetailCellType.information.reuseIdentifier)
        collectionView.register(DetailBookDescriptionCollectionViewCell.self, forCellWithReuseIdentifier: DetailCellType.description.reuseIdentifier)
        collectionView.register(DetailBookPdfCollectionViewCell.self, forCellWithReuseIdentifier: DetailCellType.pdf.reuseIdentifier)
    }
}

//MARK: - Networking
extension DetailViewController {
    func fetchBookDetail() {
        indicator.startAnimating()
        repository.fetchBookDetails(isbn13Identifier: identifier) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.handleFetchDetailResult(data)
                case .failure(let error):
                    self?.handleFetchDetailError(error)
                }
                self?.indicator.stopAnimating()
            }
        }
    }
    
    private func handleFetchDetailResult(_ data: BookDetailResponse) {
        collectionViewDataSource.setupData(by: DetailBookModel.from(bookDetailResponse: data))
        collectionView.reloadData()
    }
    
    private func handleFetchDetailError(_ error: Error) {
        let message = error.localizedDescription
        ErrorAlert.show(from: self, message: message)
    }
}

//MARK: - SetupUI
extension DetailViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "상세 정보"
        buildHierarachy()
        setupConstraint()
    }
    
    private func buildHierarachy() {
        view.addSubview(collectionView)
        view.addSubview(indicator)
    }
    
    private func setupConstraint() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            //collectionView Constraints
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            //indicator Constraints
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cellType = DetailCellType(rawValue: indexPath.row) else {
            return .zero
        }
        
        let width = collectionView.frame.width
        return CGSize(width: width, height: cellType.height)
    }
}

extension DetailViewController: PDFCollectionViewCellDelegate {
    func pdfCellDidSelectChapter(_ cell: DetailBookPdfCollectionViewCell) {
        let alertController = UIAlertController(title: "Select Chapter", message: nil, preferredStyle: .actionSheet)
        
        for (chapterName, url) in collectionViewDataSource.generatePdf() {
            let action = UIAlertAction(title: chapterName, style: .default) { _ in
                cell.loadPDF(from: url)
            }
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
