//
//  DetailBookImageCollectionViewCell.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/18/24.
//

import UIKit

/**
 상세화면 collectionView의 이미지 Cell
 
 - Note: 이미지 정보를 담고 있음
 - Date: 2023. 03. 18
 - Authors: 김도형
 */

final class DetailBookImageCollectionViewCell: UICollectionViewCell {
    //MARK: - Property
    private lazy var thumbnailImageView: AsyncImageView = {
        let imageView = AsyncImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
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
    func configure(by imageUrl: URL?) {
        guard let imageUrl = imageUrl else { return }
        thumbnailImageView.loadImage(from: imageUrl)
    }
}

//MARK: - SetupUI
extension DetailBookImageCollectionViewCell {
    private func setupUI() {
        buildHierarchy()
        setupConstraints()
    }
    
    private func buildHierarchy() {
        contentView.addSubview(thumbnailImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        
    }
}
