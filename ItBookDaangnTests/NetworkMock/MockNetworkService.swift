//
//  MockNetworkService.swift
//  ItBookDaangnTests
//
//  Created by Kim Do hyung on 3/20/24.
//

import Foundation
import ItBookDaangn

/**
 NetworkService Mock 객체
 
 - Note: MockSessionManager를 사용하여 테스트
 - Date: 2023. 03. 20
 - Authors: 김도형
 */

final class MockNetworkService: NetworkServiceable {
    var sessionManager: SessionManageable = MockSessionManager()

    func request(endpoint: Endpointable, completion: @escaping (Result<Data, Error>) -> Void) {
        sessionManager.request(urlRequest: URLRequest(url: endpoint.baseUrl.appendingPathComponent(endpoint.path))) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "com.example.error", code: -1, userInfo: nil)))
            }
        }
    }
}
