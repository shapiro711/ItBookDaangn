//
//  DetailBookDescriptionCollectionViewCell.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/18/24.
//

import UIKit

/**
 상세화면 collectionView의 상세정보 Cell
 
 - Note: 상세화면의 상세 설명을 담고 있음
 - Date: 2023. 03. 18
 - Authors: 김도형
 */

final class DetailBookDescriptionCollectionViewCell: UICollectionViewCell {
    //MARK: - Property
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption1)
        label.numberOfLines = 0
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
    func configure() {
    }
}

extension DetailBookDescriptionCollectionViewCell {
    private func setupUI() {
        buildHierarchy()
        setupConstraints()
    }
    
    private func buildHierarchy() {
        contentView.addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
}
