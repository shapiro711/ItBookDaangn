//
//  ItBookEndpointable.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/17/24.
//

import Foundation

/**
 ItBook 네트워킹 요청을 구성을 위한 프로토콜
 
 - Note: Endpointable을 채택
 - Date: 2023. 03. 17
 - Authors: 김도형
 */

protocol ItBookEndpointable: Endpointable { }

extension ItBookEndpointable {
    var baseUrl: URL {
        return URL(string: "https://api.itbook.store/1.0/")!
    }
}
