//
//  TestDetailBookRepository.swift
//  ItBookDaangnTests
//
//  Created by Kim Do hyung on 3/20/24.
//

import XCTest
@testable import ItBookDaangn

/**
 책 상세 Repository 유닛테스트
 
 - Note: 테스트 DIContainer를 통해 의존성 주입후 테스트 진행
 - Date: 2023. 03. 20
 - Authors: 김도형
 */

final class TestDetailBookRepository: XCTestCase {
    func testFetchBookDetailAuthorIsKimDoHyung() throws {
        // Given
        let repository = givenSuccessEnvironment()
        let isbn13 = "1234567890"
        let expectation = self.expectation(description: "FetchBookDetailAuthorIsKimDoHyung")
        
        // When
        repository.fetchBookDetails(isbn13Identifier: isbn13) { result in
            // Then
            switch result {
            case .success(let bookDetail):
                XCTAssertEqual(bookDetail.authors, "김도형", "김도형이 아니다")
                expectation.fulfill()
            case .failure(_):
                XCTFail("에러 발생")
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchBookDetailFailureWithStatusCode() throws {
        // Given
        let repository = givenFailEnvironment()
        let isbn13 = "1234567890"
        let expectation = self.expectation(description: "FetchBookDetailFailureWithStatusCode")
        
        // When
        repository.fetchBookDetails(isbn13Identifier: isbn13) { result in
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
extension TestDetailBookRepository {
    /// 성공 환경 설정
    func givenSuccessEnvironment() -> BookDetailFetchhable {
        let mockData = DetailBookMockData.jsonResponseData()
        let testUrl = URL(string: "https://example.com")!
        let response = HTTPURLResponse(url: testUrl, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        
        let depoendency = TestDetailDIContainer.Dependency(
            data: mockData,
            reponse: response,
            error: nil)
        let diContainer = TestDetailDIContainer(dependency: depoendency)
        return diContainer.makeRepository()
    }
    
    /// 실패 환경 설정
    func givenFailEnvironment() -> BookDetailFetchhable {
        let mockData = DetailBookMockData.jsonResponseData()
        let testUrl = URL(string: "https://example.com")!
        let response = HTTPURLResponse(url: testUrl, statusCode: 404, httpVersion: "HTTP/1.1", headerFields: nil)!
        
        let depoendency = TestDetailDIContainer.Dependency(
            data: mockData,
            reponse: response,
            error: nil)
        
        let diContainer = TestDetailDIContainer(dependency: depoendency)
        
        return diContainer.makeRepository()
    }
}
