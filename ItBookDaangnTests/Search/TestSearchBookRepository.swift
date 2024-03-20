//
//  TestBookSearchRepository.swift
//  ItBookDaangnTests
//
//  Created by Kim Do hyung on 3/20/24.
//

import XCTest
@testable import ItBookDaangn

/**
 책 검색 Repository 유닛테스트
 
 - Note: 테스트 DIContainer를 통해 의존성 주입후 테스트 진행
 - Date: 2023. 03. 20
 - Authors: 김도형
 */

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
        let mockData = SearchBookMockData.jsonResponseData()
        let testUrl = URL(string: "https://example.com")!
        let response = HTTPURLResponse(url: testUrl, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        
        let depoendency = TestSearchBookDIContainer.Dependency(
            data: mockData,
            reponse: response,
            error: nil)
        
        let diContainer = TestSearchBookDIContainer(dependency: depoendency)
        
        return diContainer.makeRepository()
    }
    
    /// 실패 환경 설정
    func givenFailEnvironment() -> BookSearchable {
        let mockData = SearchBookMockData.jsonResponseData()
        let testUrl = URL(string: "https://example.com")!
        let response = HTTPURLResponse(url: testUrl, statusCode: 404, httpVersion: "HTTP/1.1", headerFields: nil)!
        
        let depoendency = TestSearchBookDIContainer.Dependency(
            data: mockData,
            reponse: response,
            error: nil)
        
        let diContainer = TestSearchBookDIContainer(dependency: depoendency)
        
        return diContainer.makeRepository()
    }
}
