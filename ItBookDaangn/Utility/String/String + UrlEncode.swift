//
//  String + UrlEncode.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/17/24.
//

import Foundation

/**
 스트링에 대한 UrlEncode 유틸리티
 
 - Note: -
 - Date: 2023. 03. 17
 - Authors: 김도형
 */

extension String {
    func urlEncoded() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed).orEmpty
    }
}
