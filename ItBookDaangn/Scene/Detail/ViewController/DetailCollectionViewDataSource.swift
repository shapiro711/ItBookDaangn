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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItem = CellType.allCases.count
        return numberOfItem
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellType = CellType(rawValue: indexPath.row) else {
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath)
        
        switch cellType {
        case .image:
            if let cell = cell as? DetailBookImageCollectionViewCell {
                
            }
        case .information:
            if let cell = cell as? DetailBookInformationCollectionViewCell {
                
            }
        case .description:
            if let cell = cell as? DetailBookDescriptionCollectionViewCell {
               
            }
        }
        
        return cell
    }
    
    func setupData(by model: DetailBookModel) {
        self.data = model
    }
    
}

//MARK: - CellType
extension DetailCollectionViewDataSource {
    enum CellType: Int, CaseIterable {
        case image
        case information
        case description
        
        var reuseIdentifier: String {
               switch self {
               case .image:
                   return DetailBookImageCollectionViewCell.reuseIdentifier
               case .information:
                   return DetailBookInformationCollectionViewCell.reuseIdentifier
               case .description:
                   return DetailBookDescriptionCollectionViewCell.reuseIdentifier
               }
           }
        
        var indexRow: Int {
            return self.rawValue
        }
    }
}
