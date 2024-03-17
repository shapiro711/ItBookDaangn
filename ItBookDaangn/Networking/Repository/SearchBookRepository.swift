//
//  SearchBookRepository.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/17/24.
//

import Foundation

final class SearchBookRepository {
    private let networkService: NetworkServiceable

    init(networkService: NetworkServiceable) {
        self.networkService = networkService
    }

    func searchBooks(query: String, completion: @escaping (Result<[BookSearchResponse.Book], Error>) -> Void) {
        let endpoint = SearchBookEndpoint.search(query: query)
        networkService.request(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(BookSearchResponse.self, from: data)
                    completion(.success(response.books ?? []))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
