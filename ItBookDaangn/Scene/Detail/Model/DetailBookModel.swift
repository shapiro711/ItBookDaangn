//
//  DetailBookModel.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/18/24.
//

import Foundation

/**
 책 상세 UI에 사용할 데이터 구조
 
 - Note: -
 - Date: 2023. 03. 18
 - Authors: 김도형
 */

struct DetailBookModel {
    let title: String
    let subtitle: String
    let authors: String
    let publisher: String
    let isbn10: String
    let isbn13: String
    let pages: String
    let year: String
    let rating: String
    let description: String
    let price: String
    let imageUrl: URL?
    let linkUrl: URL?
    let chapterPdfUrls: [String: URL]?
}

extension DetailBookModel {
    /// DetailBookModel Factory 메서드
    static func from(bookDetailResponse: BookDetailResponse) -> DetailBookModel {
        let title = bookDetailResponse.title ?? "제목 정보 없음"
        let subtitle = bookDetailResponse.subtitle ?? "부제목 정보 없음"
        let authors = bookDetailResponse.authors ?? "저자 정보 없음"
        let publisher = bookDetailResponse.publisher ?? "출판사 정보 없음"
        let isbn10 = bookDetailResponse.isbn10 ?? "ISBN10 정보 없음"
        let isbn13 = bookDetailResponse.isbn13 ?? "ISBN13 정보 없음"
        let pagesString = bookDetailResponse.pages ?? "페이지 정보 없음"
        let year = bookDetailResponse.year ?? "년도 정보 없음"
        let ratingString = bookDetailResponse.rating ?? "평점 정보 없음"
        let description = bookDetailResponse.description ?? "설명 정보 없음"
        let price = bookDetailResponse.price ?? "가격 정보 없음"
        
        return DetailBookModel(title: title,
                               subtitle: subtitle,
                               authors: authors,
                               publisher: publisher,
                               isbn10: isbn10,
                               isbn13: isbn13,
                               pages: pagesString,
                               year: year,
                               rating: ratingString,
                               description: description,
                               price: price,
                               imageUrl: bookDetailResponse.imageUrl,
                               linkUrl: bookDetailResponse.linkUrl,
                               chapterPdfUrls: bookDetailResponse.chapterPdfUrls)
    }
}
