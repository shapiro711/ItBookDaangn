//
//  SearchBookEndpoint.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/17/24.
//

import Foundation

/**
 책 검색 Endpoint
 
 - Note: query를 통한 path 구성
 - Date: 2023. 03. 17
 - Authors: 김도형
 */

enum SearchBookEndpoint: ItBookEndpointable {
    case search(query: String, page: Int)
    
    var path: String {
        switch self {
        case .search(let query, let page):
            let pageString = page.description
            return "search/\(query.urlEncoded())/\(pageString.urlEncoded())"
        }
    }

    var method: HttpMethod {
        return .get
    }

    var headers: [String: String]? {
        return nil
    }

    var body: Data? {
        return nil
    }
}
