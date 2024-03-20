//
//  BookDetailResponse.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/17/24.
//

import Foundation

/**
 책 상세 네트워킹 응답에 대한 데이터 구조
 
 - Note: -
 - Date: 2023. 03. 17
 - Authors: 김도형
 */

struct BookDetailResponse: Codable {
    let error: String?
    let title: String?
    let subtitle: String?
    let authors: String?
    let language: String?
    let publisher: String?
    let isbn10: String?
    let isbn13: String?
    let pages: String?
    let year: String?
    let rating: String?
    let description: String?
    let price: String?
    let imageUrl: URL?
    let linkUrl: URL?
    let chapterPdfUrls: [String: URL]?

    enum CodingKeys: String, CodingKey {
        case error, title, subtitle, authors, publisher, isbn10, isbn13, pages, year, rating, price, language
        case description = "desc"
        case imageUrl = "image"
        case linkUrl = "url"
        case chapterPdfUrls = "pdf"
    }
}
