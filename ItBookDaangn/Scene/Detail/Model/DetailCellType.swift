//
//  DetailCellType.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/20/24.
//

import Foundation

/**
 상세 화면에서 사용되는 Cell들의 정의
 
 - Note: reuseIdentifier, index, height에 대한 정보를 가지고있음
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
    
    var height: Double {
        switch self {
        case .image:
            return 300
        case .title:
            return 50
        case .information:
            return 170
        case .description:
            return 120
        case .pdf:
            return 500
        }
    }
}
