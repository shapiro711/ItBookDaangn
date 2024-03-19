//
//  UICollectionView + EmptyView.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/17/24.
//

import UIKit

/**
 CollectionView에서 데이터가 없을때 EmptyView를 사용하기 위한 확장 유틸
 
 - Note: -
 - Date: 2023. 03. 17
 - Authors: 김도형
 */

extension UICollectionView {
    func setEmptyMessage(_ message: String) {
        let emptyMessageLabel: UILabel = {
            let label = UILabel()
            label.font = .preferredFont(forTextStyle: .title2)
            label.textAlignment = .center
            label.sizeToFit()
            label.text = message
            return label
        }()
        
        self.backgroundView = emptyMessageLabel
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
