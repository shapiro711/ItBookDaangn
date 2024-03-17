//
//  SessionManager.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/16/24.
//

import Foundation

/**
 실제 URLSession을 통한 통신 담당
 
 - Note: SessionManageable을 통한 추상화 유연성 확보
 - Date: 2023. 03. 16
 - Authors: 김도형
 */

protocol SessionManageable {
    func request(urlRequest: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

final class SessionManager: SessionManageable {
    func request(urlRequest: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: completion)
        dataTask.resume()
    }
}
