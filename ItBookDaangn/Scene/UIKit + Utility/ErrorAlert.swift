//
//  ErrorAlert.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/20/24.
//

import UIKit

/**
 에러에 대한 Alert을 생성해주고 보여준다.
 
 - Note: -
 - Date: 2023. 03. 20
 - Authors: 김도형
 */

struct ErrorAlert {
    static func show(from viewController: UIViewController, message: String) {
        let alertController = UIAlertController(title: "에러 발생", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default)
        alertController.addAction(okAction)
        
        viewController.present(alertController, animated: true)
    }
}
