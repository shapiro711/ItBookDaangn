//
//  MockBookDetailResponse.swift
//  ItBookDaangnTests
//
//  Created by Kim Do hyung on 3/20/24.
//

import Foundation
import ItBookDaangn

struct MockBookDetailResponse {
    static func defaultResponse() -> BookDetailResponse {
        return BookDetailResponse(
            error: "0",
            title: "테스트타이틀",
            subtitle: "테스트서브타이틀",
            authors: "김도형",
            language: "한국어",
            publisher: "좋은출판사",
            isbn10: "1234567890",
            isbn13: "0987654321",
            pages: "350",
            year: "2024",
            rating: "4",
            description: "테스트설명",
            price: "이천원",
            imageUrl: nil,
            linkUrl: nil,
            chapterPdfUrls = [:]
        )
    }
    
    static func responseData() -> Data? {
        let response = defaultResponse()
        let encoder = JSONEncoder()
        return try? encoder.encode(response)
    }
}
