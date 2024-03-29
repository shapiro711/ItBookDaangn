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
    private var linkUrl: URL?
    
    private lazy var thumbnailImageView: AsyncImageView = {
        let imageView = AsyncImageView()
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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .orange
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    
    private lazy var identifierLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    private lazy var linkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .blue
        label.text = "링크"
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
    func configure(by model: SearchBookModel) {
        let placeHolder = UIImage(systemName: "photo")
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        identifierLabel.text = "isbnID: \(model.isbn13Identifier)"
        
        if let imageUrl = model.imageUrl {
            thumbnailImageView.loadImage(from: imageUrl, placeholder: placeHolder)
        }
        
        linkUrl = model.linkUrl
    }
}

extension SearchBookCollectionViewCell {
    private func setupUI() {
        buildHierarchy()
        setupConstraints()
        setupLinkLabelAction()
    }
    
    private func buildHierarchy() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(titleStackView)
        contentView.addSubview(linkLabel)
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(subtitleLabel)
        titleStackView.addArrangedSubview(identifierLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            //thumbnailImageView Constraints
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 120),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 90),
            thumbnailImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            //titleStackView Constraints
            titleStackView.topAnchor.constraint(equalTo: thumbnailImageView.topAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 8),
            titleStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            //linkLabel Constraints
            linkLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            linkLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
    }
}

//MARK: - Action
extension SearchBookCollectionViewCell {
    func setupLinkLabelAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openLink))
        linkLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc func openLink() {
        guard let linkUrl = linkUrl else { return }
        if UIApplication.shared.canOpenURL(linkUrl) {
            UIApplication.shared.open(linkUrl)
        }
    }
}
