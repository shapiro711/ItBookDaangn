//
//  Paginationable.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/18/24.
//

import Foundation

/**
 페이지네이션 로직 추상화 Protocol
 
 - Note: -
 - Date: 2023. 03. 10
 - Authors: 김도형
 */

protocol Paginationable {
    var pageInformation: PageInformation { get set }
    func resetPage()
}

struct PageInformation {
    var currentPage: Int = 0
    var canFetchNextPage: Bool = true
    var fetchedBooksCount: Int = 0
}

enum PageError: Error {
    case endPage
}
