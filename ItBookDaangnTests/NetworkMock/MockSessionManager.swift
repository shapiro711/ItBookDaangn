//
//  MockSessionManager.swift
//  ItBookDaangnTests
//
//  Created by Kim Do hyung on 3/20/24.
//

import Foundation
import ItBookDaangn

class MockSessionManager: SessionManageable {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?
    
    func request(urlRequest: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completion(mockData, mockResponse, mockError)
    }
}
