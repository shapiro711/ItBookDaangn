//
//  SearchBookRepository.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/17/24.
//

import Foundation

/**
 책 검색 Repository 객체
 
 - Note: 페이징, 디코딩에 관한 로직 처리
 - Date: 2023. 03. 17
 - Authors: 김도형
 */

final class SearchBookRepository {
    private let networkService: NetworkServiceable

    init(networkService: NetworkServiceable) {
        self.networkService = networkService
    }

    func searchBooks(query: String,
                     completion: @escaping (Result<[BookSearchResponse.Book], Error>) -> Void) {
        let endpoint = SearchBookEndpoint.search(query: query)
        
        networkService.request(endpoint: endpoint) { result in
            let finalResult = result
                .flatMap { data -> Result<BookSearchResponse, Error> in
                    DecodingManager.decode(BookSearchResponse.self, from: data).mapError { $0 as Error }
                }
                .map { response -> [BookSearchResponse.Book] in
                    response.books ?? []
                }
            
            completion(finalResult)
        }
    }
}
