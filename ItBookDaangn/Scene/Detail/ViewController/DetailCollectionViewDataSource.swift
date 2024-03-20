//
//  DetailCollectionViewDataSource.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/18/24.
//

import UIKit

/**
 상세화면 collectionView의 DataSource
 
 - Note: 그려야할 데이터에 대한 관리 책임
 - Date: 2023. 03. 18
 - Authors: 김도형
 */

final class DetailCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    private var data: DetailBookModel?
    private weak var pdfCellDelegate: PDFCollectionViewCellDelegate?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItem = DetailCellType.allCases.count
        return numberOfItem
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellType = DetailCellType(rawValue: indexPath.row) else {
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath)
        
        configureCell(cell, for: cellType)
        
        return cell
    }
}

//MARK: - Interface
extension DetailCollectionViewDataSource {
    func setupData(by model: DetailBookModel) {
        self.data = model
    }
    
    func generatePdf() -> [String: URL] {
        guard let chapterPdfUrls = data?.chapterPdfUrls else { return [:]}
        return chapterPdfUrls
    }
    
    func setupDelegate(_ delegate: PDFCollectionViewCellDelegate) {
        self.pdfCellDelegate = delegate
    }
}

//MARK: - Configure
extension DetailCollectionViewDataSource {
    private func configureCell(_ cell: UICollectionViewCell, for type: DetailCellType) {
        switch type {
        case .image:
            let imageCell = cell as? DetailBookImageCollectionViewCell
            imageCell?.configure(by: data?.imageUrl)
        case .title:
            let titleCell = cell as? DetailBookTitleCollectionViewCell
            titleCell?.configure(by: data)
        case .information:
            let infoCell = cell as? DetailBookInformationCollectionViewCell
            infoCell?.configure(by: data)
        case .description:
            let descriptionCell = cell as? DetailBookDescriptionCollectionViewCell
            descriptionCell?.configure(by: data)
        case .pdf:
            let pdfCell = cell as? DetailBookPdfCollectionViewCell
            pdfCell?.delegate = pdfCellDelegate
        }
    }
}
