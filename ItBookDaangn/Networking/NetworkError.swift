//
//  NetworkError.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/16/24.
//

import Foundation

/**
 네트워킹시 발생하는 CustomError 정의
 
 - Note: -
 - Date: 2023. 03. 16
 - Authors: 김도형
 */

enum NetworkError: Error {
    case networkError(Error)
    case abnormalResponse
    case notExistData
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .networkError:
            return "네트워크 연결에 문제가 발생했습니다. 나중에 다시 시도해주세요."
        case .abnormalResponse:
            return "잘못된 요청입니다. 다시 시도해주세요."
        case .notExistData:
            return "데이터가 없습니다. 다시 시도해주세요."
        }
    }
}
