//
//  SearchBookMockData.swift
//  ItBookDaangnTests
//
//  Created by Kim Do hyung on 3/20/24.
//

import Foundation
@testable import ItBookDaangn

struct SearchBookMockData {
    static func jsonResponseData() -> Data? {
        let jsonString = """
        {
            "error": "0",
            "total": "1",
            "page": "1",
            "books": [
                {
                    "title": "스위프트",
                    "subtitle": "스위프트서브타이틀",
                    "isbn13": "9781617291609",
                    "price": "오백원",
                    "image": "testurl",
                    "url": "testurl"
                }
            ]
        }
        """

        return jsonString.data(using: .utf8)
    }
}
