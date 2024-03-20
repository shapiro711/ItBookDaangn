//
//  TestDetailDIContainer.swift
//  ItBookDaangnTests
//
//  Created by Kim Do hyung on 3/20/24.
//

import Foundation
@testable import ItBookDaangn

/**
 책 상세 테스트 DIContainer
 
 - Note: Mock 객체들에 대한 의존성 주입 및 구현체 구현
 - Date: 2023. 03. 20
 - Authors: 김도형
 */

final class TestDetailDIContainer {
    
    /// 외부에서 주입 받을 의존성
    struct Dependency {
        let data: Data?
        let reponse: HTTPURLResponse?
        let error: Error?
    }
    
    private let dependency: Dependency
    
    init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    func makeRepository() -> BookDetailFetchhable {
        return BookDetailRepository(networkService: makeMockNetworkService())
    }
    
    func makeMockNetworkService() -> NetworkServiceable {
        return MockNetworkService(sessionManager: makeMockSessionManager())
    }
    
    func makeMockSessionManager() -> SessionManageable {
        let mockSessionManager = MockSessionManager()
        mockSessionManager.mockData = dependency.data
        mockSessionManager.mockResponse = dependency.reponse
        return mockSessionManager
    }
}
