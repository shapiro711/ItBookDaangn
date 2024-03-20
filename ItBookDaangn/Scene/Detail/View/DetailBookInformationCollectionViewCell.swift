//
//  DetailBookInformationCollectionViewCell.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/18/24.
//

import UIKit

/**
 상세화면 collectionView의 정보 Cell
 
 - Note: 타이틀, 서브타이틀 등의 정보를 담고 있음
 - Date: 2023. 03. 18
 - Authors: 김도형
 */

final class DetailBookInformationCollectionViewCell: UICollectionViewCell {
    //MARK: - Property
    private lazy var informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var identifierStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    
    private lazy var ahtorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    
    private lazy var publisherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    private lazy var pageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    private lazy var linkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .blue
        label.text = "링크"
        return label
    }()
    
    private lazy var isbn10IdentifierLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    private lazy var isbn13IdentifierLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    
    
    //MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    func configure(by model: DetailBookModel?) {
        guard let model = model else { return }
        ahtorLabel.text = "작가:" + model.authors
        publisherLabel.text = "출판사:" + model.publisher
        pageLabel.text = "페이지:" + model.pages
        yearLabel.text = "출판 년도:" + model.year
        ratingLabel.text = "평점:" + model.rating
        priceLabel.text = "가격:" + model.price
        isbn10IdentifierLabel.text = "isbn10:" + model.isbn10
        isbn13IdentifierLabel.text = "isbn13:" + model.isbn13
    }
}

//MARK: - SetupUI
extension DetailBookInformationCollectionViewCell {
    private func setupUI() {
        buildHierarchy()
        setupConstraints()
    }
    
    private func buildHierarchy() {
        contentView.addSubview(informationStackView)
        
        informationStackView.addArrangedSubview(priceLabel)
        informationStackView.addArrangedSubview(ahtorLabel)
        informationStackView.addArrangedSubview(publisherLabel)
        informationStackView.addArrangedSubview(pageLabel)
        informationStackView.addArrangedSubview(yearLabel)
        informationStackView.addArrangedSubview(ratingLabel)
        
        informationStackView.addArrangedSubview(identifierStackView)
        
        identifierStackView.addArrangedSubview(isbn10IdentifierLabel)
        identifierStackView.addArrangedSubview(isbn13IdentifierLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            informationStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            informationStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            informationStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
}
