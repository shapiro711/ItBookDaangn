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
    case undefined(Error)
    case abnormalResponse
    case notExistData
}
