//
//  SearchCollectionViewDataSource.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/17/24.
//

import UIKit

/**
 검색화면 collectionView의 DataSource
 
 - Note: 그려야할 데이터에 대한 관리 책임
 - Date: 2023. 03. 16
 - Authors: 김도형
 */

final class SearchCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchBookCollectionViewCell.reuseIdentifier, for: indexPath) as? SearchBookCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}
