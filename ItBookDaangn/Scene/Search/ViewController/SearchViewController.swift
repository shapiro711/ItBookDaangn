//
//  SearchViewController.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/16/24.
//

import UIKit

/**
 책 검색 화면 ViewController
 
 - Note: -
 - Date: 2023. 03. 16
 - Authors: 김도형
 */

final class SearchViewController: UIViewController {
    //MARK: - Property
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    //MARK: - Initializer
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
}
