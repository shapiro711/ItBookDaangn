//
//  Requestable.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/16/24.
//

import Foundation

/**
 네트워킹 요청을 구성을 위한 프로토콜
 
 - Note: -
 - Date: 2023. 03. 16
 - Authors: 김도형
 */

protocol Requestable {
    var baseUrl: URL { get }
    var path: String { get }
    var method: HttpMethod { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}
