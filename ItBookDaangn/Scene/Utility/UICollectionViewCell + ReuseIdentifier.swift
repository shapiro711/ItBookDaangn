//
//  UICollectionViewCell + ReuseIdentifier.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/17/24.
//

import UIKit

/**
 CollectionViewCell reuseIdentifier를 사용하기 위한 확장 유틸
 
 - Note: -
 - Date: 2023. 03. 17
 - Authors: 김도형
 */

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
