//
//  NetworkServiceable.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/16/24.
//

import Foundation

/**
 NetworkService를 추상화한 protocol
 
 - Note: -
 - Date: 2023. 03. 16
 - Authors: 김도형
 */

protocol NetworkServiceable {
    func request(endpoint: Endpointable, completion: @escaping (Result<Data, Error>) -> Void)
}

//
struct NetworkResponse {
    let data: Data?
    let response: URLResponse?
    let error: Error?
}

final class NetworkService: NetworkServiceable {
    private let sessionManager: SessionManageable

    init(sessionManager: SessionManageable) {
        self.sessionManager = sessionManager
    }
    
    func request(endpoint: Endpointable, completion: @escaping (Result<Data, Error>) -> Void) {
        let urlRequest = generateRequest(from: endpoint)
        
        sessionManager.request(urlRequest: urlRequest) { [weak self] data, response, error in
            guard let self = self else { return }
            
            let networkResponse = NetworkResponse(data: data, response: response, error: error)
            self.handleResponse(networkResponse: networkResponse, completion: completion)
        }
    }
    
    private func handleResponse(networkResponse: NetworkResponse, completion: @escaping (Result<Data, Error>) -> Void) {
        if let error = networkResponse.error {
            completion(.failure(NetworkError.undefined(error)))
            return
        }
        guard let httpResponse = networkResponse.response as? HTTPURLResponse, self.isValidStatusCode(httpResponse.statusCode) else {
            completion(.failure(NetworkError.abnormalResponse))
            return
        }
        guard let data = networkResponse.data else {
            completion(.failure(NetworkError.notExistData))
            return
        }
        completion(.success(data))
    }
    
    private func isValidStatusCode(_ statusCode: Int) -> Bool {
        return 200..<300 ~= statusCode
    }
    
    private func generateRequest(from endpoint: Endpointable) -> URLRequest {
        var request = URLRequest(url: endpoint.baseUrl.appendingPathComponent(endpoint.path))
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        endpoint.headers?.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
}
