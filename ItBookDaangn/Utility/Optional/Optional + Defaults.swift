//
//  Optional + Defaults.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/17/24.
//

import Foundation

/**
 옵셔널 nil 병합 연산자에 대한 확장 유틸리티
 
 - Note: String, Int에 대한 확장 존재
 - Date: 2023. 03. 17
 - Authors: 김도형
 */

extension Optional where Wrapped == String {
    var orEmpty: String {
        return self ?? ""
    }
}

extension Optional where Wrapped == Int {
    var orZero: Int {
        return self ?? 0
    }
}
