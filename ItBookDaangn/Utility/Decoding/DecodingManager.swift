//
//  DecodingManager.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/17/24.
//

import Foundation

/**
 디코딩 로직을 수행하는 유틸리티 객체
 
 - Note: -
 - Date: 2023. 03. 17
 - Authors: 김도형
 */

struct DecodingManager {
    static func decode<T: Decodable>(_ type: T.Type,
                                     from data: Data?) -> Result<T, DecodingError> {
        guard let data = data else {
            return .failure(.dataMissing)
        }
        
        do {
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedObject)
        } catch {
            return .failure(.decodingFailed(error))
        }
    }
}
