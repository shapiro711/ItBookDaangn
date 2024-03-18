//
//  BookSearchResponse.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/17/24.
//

import Foundation

/**
 책 검색 네트워킹 응답에 대한 데이터 구조
 
 - Note: -
 - Date: 2023. 03. 17
 - Authors: 김도형
 */

struct BookSearchResponse: Decodable {
    let total: String?
    let page: String?
    let books: [Book]?
    
    struct Book: Decodable {
        let title: String?
        let subtitle: String?
        let isbn13Identifier: String?
        let price: String?
        let imageUrl: URL?
        let linkUrl: URL?
        
        enum CodingKeys: String, CodingKey {
            case title, subtitle, price
            case isbn13Identifier = "isbn13"
            case imageUrl = "image"
            case linkUrl = "url"
        }
    }
}
