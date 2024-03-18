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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
