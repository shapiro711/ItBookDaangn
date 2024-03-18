//
//  Paginationable.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/18/24.
//

import Foundation

protocol Paginationable {
    var pageInformation: PageInformation { get set }
    func resetPage()
}

struct PageInformation {
    var currentPage: Int = 0
    var canFetchNextPage: Bool = true
    var fetchedBooksCount: Int = 0
}
