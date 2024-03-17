//
//  DetailBookEndpoint.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/17/24.
//

import Foundation

/**
 책 상세 Endpoint
 
 - Note: isbn를 통한 path 구성
 - Date: 2023. 03. 17
 - Authors: 김도형
 */

enum DetailBookEndpoint: ItBookEndpointable {
    case fetchBook(isbn13Identifier: String)
    
    var path: String {
        switch self {
        case .fetchBook(let isbn13Identifier):
            return "books/\(isbn13Identifier)"
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
