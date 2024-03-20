//
//  DetailBookMockData.swift
//  ItBookDaangnTests
//
//  Created by Kim Do hyung on 3/20/24.
//

import Foundation
@testable import ItBookDaangn

/**
 책 상세 Mock 데이터
 
 - Note: -
 - Date: 2023. 03. 20
 - Authors: 김도형
 */


struct DetailBookMockData {
    static func jsonResponseData() -> Data? {
        let jsonString = """
            {
              "error": "0",
              "title": "테스트타이틀",
              "subtitle": "테스트서브타이틀",
              "authors": "김도형",
              "language": "한국어",
              "publisher": "좋은출판사",
              "isbn10": "1234567890",
              "isbn13": "0987654321",
              "pages": "350",
              "year": "2024",
              "rating": "4",
              "description": "테스트설명",
              "price": "이천원",
              "image": null,
              "url": null,
              "pdf": {}
            }
            """
        
        return jsonString.data(using: .utf8)
    }
}
