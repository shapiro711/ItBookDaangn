//
//  SearchBookCollectionViewCell.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/17/24.
//

import UIKit

/**
 검색화면 collectionView의 Cell
 
 - Note: 검색된 책에 대한 UI를 나타내주는 Cell
 - Date: 2023. 03. 17
 - Authors: 김도형
 */

final class SearchBookCollectionViewCell: UICollectionViewCell {
    //MARK: - Property
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 18
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.text = "title"
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.text = "subtitle"
        return label
    }()
    
    private lazy var identifierLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.text = "isbn"
        return label
    }()
    
    private lazy var linkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.text = "link"
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
}

extension SearchBookCollectionViewCell {
    private func setupUI() {
        buildHierarchy()
        setupConstraints()
    }
    
    private func buildHierarchy() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(titleStackView)
        contentView.addSubview(informationStackView)
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(subtitleLabel)
        titleStackView.addArrangedSubview(informationStackView)
        
        informationStackView.addArrangedSubview(identifierLabel)
        informationStackView.addArrangedSubview(linkLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            //thumbnailImageView constraints
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 120),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 90),
            thumbnailImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            //titleStackView constraints
            titleStackView.topAnchor.constraint(equalTo: thumbnailImageView.topAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 8),
            titleStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        
    }
}
