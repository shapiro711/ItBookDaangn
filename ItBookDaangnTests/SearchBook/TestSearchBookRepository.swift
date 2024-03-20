//
//  TestBookSearchRepository.swift
//  ItBookDaangnTests
//
//  Created by Kim Do hyung on 3/20/24.
//

import XCTest
@testable import ItBookDaangn

final class TestBookSearchRepository: XCTestCase {
    func testSearchBookPriceIs500() throws {
        // Given
        let repository = givenSuccessEnvironment()
        let query = "test"
        let expectation = self.expectation(description: "BookPriceIs500")
        
        // When
        repository.searchBooks(query: query) { result in
            // Then
            switch result {
            case .success(let searchResult):
                XCTAssertEqual(searchResult.first?.price, "오백원", "오백원 아니다")
                expectation.fulfill()
            case .failure(_):
                XCTFail("에러 발생")
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testSearchBookFailureWithStatusCode() throws {
        // Given
        let repository = givenFailEnvironment()
        let query = "test"
        let expectation = self.expectation(description: "SearchBookFailureWithStatusCode")
        
        // When
        repository.searchBooks(query: query) { result in
            // Then
            switch result {
            case .success(_):
                XCTFail("실패가 예상되었으나 성공적으로 처리됨")
            case .failure(_):
                // 예상된 실패
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}

//MARK: - Make Environment
extension TestBookSearchRepository {
    /// 성공 환경 설정
    func givenSuccessEnvironment() -> BookSearchable {
        let mockSessionManager = MockSessionManager()
        let mockData = SearchBookMockData.jsonResponseData()
        
        let testUrl = URL(string: "https://example.com")!
        let response = HTTPURLResponse(url: testUrl, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        mockSessionManager.mockResponse = response
        mockSessionManager.mockData = mockData
        
        let mockNetworkService = NetworkService(sessionManager: mockSessionManager)
        return SearchBookRepository(networkService: mockNetworkService)
    }
    
    /// 실패 환경 설정
    func givenFailEnvironment() -> BookSearchable {
        let mockSessionManager = MockSessionManager()
        let mockData = SearchBookMockData.jsonResponseData()
        
        let testUrl = URL(string: "https://example.com")!
        let response = HTTPURLResponse(url: testUrl, statusCode: 404, httpVersion: "HTTP/1.1", headerFields: nil)!
        mockSessionManager.mockResponse = response
        mockSessionManager.mockData = mockData
        
        let mockNetworkService = NetworkService(sessionManager: mockSessionManager)
        return SearchBookRepository(networkService: mockNetworkService)
    }
}
