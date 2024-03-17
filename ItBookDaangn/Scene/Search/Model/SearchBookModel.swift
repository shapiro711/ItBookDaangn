//
//  SearchBookModel.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/17/24.
//

import Foundation

/**
 책 검색 UI에 사용할 데이터 구조
 
 - Note: -
 - Date: 2023. 03. 17
 - Authors: 김도형
 */

struct SearchBookModel {
    let title: String
    let subtitle: String
    let isbn13Identifier: String
    let price: String
    let imageUrl: URL?
    let linkUrl: URL?
    
    /// SearchBookModel Factory 메서드
    static func makeSearchBookModel(by response: BookSearchResponse.Book) -> SearchBookModel {
        let title = response.title ?? "제목 정보 없음"
        let subtitle = response.subtitle ?? "부제목 정보 없음"
        let isbn13Identifier = response.isbn13Identifier ?? "ISBN 정보 없음"
        let price = response.price ?? "가격 정보 없음"
        
        return SearchBookModel(title: title,
                               subtitle: subtitle,
                               isbn13Identifier: isbn13Identifier,
                               price: price, 
                               imageUrl: response.imageUrl,
                               linkUrl: response.linkUrl)
    }
}
