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

protocol BookSearchable: Paginationable {
    func searchBooks(query: String,
                     completion: @escaping (Result<[BookSearchResponse.Book], Error>) -> Void)
}

final class SearchBookRepository: BookSearchable {
    var pageInformation: PageInformation = PageInformation()
    private let networkService: NetworkServiceable

    init(networkService: NetworkServiceable) {
        self.networkService = networkService
    }

    /// 책 검색 실행
    func searchBooks(query: String, completion: @escaping (Result<[BookSearchResponse.Book], Error>) -> Void) {
        guard pageInformation.canFetchNextPage else {
            completion(.failure(PageError.endPage))
            return
        }
        
        let currentPage = pageInformation.currentPage + 1
        let endpoint = SearchBookEndpoint.search(query: query, page: currentPage)
        
        networkService.request(endpoint: endpoint) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let response = try self?.decodeBookSearchResponse(from: data)
                    self?.updatePageInformation(with: response, currentPage: currentPage)
                    completion(.success(response?.books ?? []))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// 리스폰스 디코딩
    func decodeBookSearchResponse(from data: Data) throws -> BookSearchResponse {
        do {
            let decodedResponse = try JSONDecoder().decode(BookSearchResponse.self, from: data)
            return decodedResponse
        } catch {
            throw error
        }
    }

    /// 페이지네이션 정보 업데이트
    func updatePageInformation(with response: BookSearchResponse?, currentPage: Int) {
        guard let response = response, let fetchedBooksCount = response.books?.count else { return }
        self.pageInformation.fetchedBooksCount += fetchedBooksCount
        self.pageInformation.currentPage = currentPage
        self.pageInformation.canFetchNextPage = self.pageInformation.fetchedBooksCount < (Int(response.total ?? "") ?? 0)
    }
    
    /// 페이지네이션 리셋
    func resetPage() {
        pageInformation.fetchedBooksCount = 0
        pageInformation.canFetchNextPage = true
        pageInformation.currentPage = 0
    }
}
