//
//  DetailBookDIContainer.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/18/24.
//

import Foundation
/**
 책 상세 화면 DIContainer
 
 - Note: 각각의 구현체를 주입시켜 조립 , 최종적으로 DetailViewController 반환
 - Date: 2023. 03. 17
 - Authors: 김도형
 */

import Foundation

final class DetailBookDIContainer {
    struct Dependency {
        let isbn13Identifier: String
    }
    
    let dependency: Dependency
    
    init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    func makeViewController() -> DetailViewController {
        return DetailViewController(repository: makeRepository(), 
                                    identifier: dependency.isbn13Identifier)
    }
    
    private func makeRepository() -> BookDetailFetchhable {
        return BookDetailRepository(networkService: makeNetworkService())
    }
    
    private func makeNetworkService() -> NetworkServiceable {
        return NetworkService(sessionManager: makeSesssionManager())
    }
    
    private func makeSesssionManager() -> SessionManageable {
        return SessionManager()
    }
}
