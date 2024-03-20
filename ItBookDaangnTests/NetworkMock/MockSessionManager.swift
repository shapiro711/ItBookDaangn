//
//  MockSessionManager.swift
//  ItBookDaangnTests
//
//  Created by Kim Do hyung on 3/20/24.
//

import Foundation
import ItBookDaangn

/**
 SessionManager Mock 객체
 
 - Note: 필요한 Mock 데이터를 받아와 사용
 - Date: 2023. 03. 20
 - Authors: 김도형
 */

final class MockSessionManager: SessionManageable {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?
    
    func request(urlRequest: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completion(mockData, mockResponse, mockError)
    }
}
