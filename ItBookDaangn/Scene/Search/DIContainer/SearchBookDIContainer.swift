//
//  SearchBookDIContainer.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/17/24.
//

/**
 책 검색 화면 DIContainer
 
 - Note: 각각의 구현체를 주입시켜 조립 , 최종적으로 SearchViewController 반환
 - Date: 2023. 03. 17
 - Authors: 김도형
 */

import Foundation

final class SearchBookDIContainer {
    func makeViewController() -> SearchViewController {
        return SearchViewController(searchBookRepository: makeRepository())
    }
    
    private func makeRepository() -> BookSearchable {
        return SearchBookRepository(networkService: makeNetworkService())
    }
    
    private func makeNetworkService() -> NetworkServiceable {
        return NetworkService(sessionManager: makeSesssionManager())
    }
    
    private func makeSesssionManager() -> SessionManageable {
        return SessionManager()
    }
}
