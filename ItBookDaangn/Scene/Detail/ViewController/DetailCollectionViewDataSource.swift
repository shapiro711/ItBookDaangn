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

enum DetailCellType: Int, CaseIterable {
    case image
    case title
    case information
    case description
    case pdf
    
    var reuseIdentifier: String {
           switch self {
           case .image:
               return DetailBookImageCollectionViewCell.reuseIdentifier
           case .title:
               return DetailBookTitleCollectionViewCell.reuseIdentifier
           case .information:
               return DetailBookInformationCollectionViewCell.reuseIdentifier
           case .description:
               return DetailBookDescriptionCollectionViewCell.reuseIdentifier
           case .pdf:
               return DetailBookPdfCollectionViewCell.reuseIdentifier
           }
       }
    
    var indexRow: Int {
        return self.rawValue
    }
}

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
        
        switch cellType {
        case .image:
            if let cell = cell as? DetailBookImageCollectionViewCell {
                cell.configure(by: data?.imageUrl)
            }
        case .title:
            if let cell = cell as? DetailBookTitleCollectionViewCell {
                cell.configure(by: data)
            }
        case .information:
            if let cell = cell as? DetailBookInformationCollectionViewCell {
                cell.configure(by: data)
            }
        case .description:
            if let cell = cell as? DetailBookDescriptionCollectionViewCell {
                cell.configure(by: data)
            }
        case .pdf:
            if let cell = cell as? DetailBookPdfCollectionViewCell {
                cell.delegate = self.pdfCellDelegate
            }
        }
        
        return cell
    }
    
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
