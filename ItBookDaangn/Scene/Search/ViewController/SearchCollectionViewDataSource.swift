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
    private var data: [SearchBookModel] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = data.count
        
        if count == .zero {
            collectionView.setEmptyMessage("데이터가 없습니다.")
        } else {
            collectionView.restore()
        }
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchBookCollectionViewCell.reuseIdentifier, for: indexPath) as? SearchBookCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(by: data[indexPath.row])
        
        return cell
    }
}

//MARK: - Interface
extension SearchCollectionViewDataSource {
    func setupData(by model: [SearchBookModel]) {
        self.data = model
    }
    
    func appendData(by model: [SearchBookModel]) {
        self.data.append(contentsOf: model)
    }
    
    func resetData() {
        self.data.removeAll()
    }
    
    func generateIdentifier(by index: IndexPath) -> String {
        return self.data[index.row].isbn13Identifier
    }
}
