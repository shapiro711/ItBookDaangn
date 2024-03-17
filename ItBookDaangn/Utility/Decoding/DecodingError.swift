//
//  DecodingError.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/17/24.
//

import Foundation

/**
 디코딩시 발생하는 커스텀 에러 정의
 
 - Note: -
 - Date: 2023. 03. 17
 - Authors: 김도형
 */

enum DecodingError: Error {
    case dataMissing
    case decodingFailed(Error)
}
