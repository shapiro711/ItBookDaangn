//
//  DetailBookRepository.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/17/24.
//

import Foundation

/**
 책 상세 Repository 객체
 
 - Note: 페이징, 디코딩에 관한 로직 처리
 - Date: 2023. 03. 17
 - Authors: 김도형
 */

final class BookDetailRepository {
    private let networkService: NetworkServiceable

    init(networkService: NetworkServiceable) {
        self.networkService = networkService
    }

    func fetchBookDetails(isbn13Identifier: String,
                          completion: @escaping (Result<BookDetailResponse, Error>) -> Void) {
        let endpoint = DetailBookEndpoint.fetchBook(isbn13Identifier: isbn13Identifier)
        
        networkService.request(endpoint: endpoint) { result in
            let finalResult = result
                .flatMap { data -> Result<BookDetailResponse, Error> in
                    DecodingManager.decode(BookDetailResponse.self, from: data).mapError { $0 as Error }
                }
            
            completion(finalResult)
        }
    }
}
