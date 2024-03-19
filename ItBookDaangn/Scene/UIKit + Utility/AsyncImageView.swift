//
//  AsyncImageView.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/19/24.
//

import UIKit

/**
  비동기적으로 다운로딩을 하는 ImageView
 
 - Note: 셀의 재사용과 비동기 상황에서 발생할 수 있는 문제 처리
 - Date: 2023. 03. 19
 - Authors: 김도형
 */

final class AsyncImageView: UIImageView {
    private var currentURL: URL?
    
    func loadImage(from url: URL, placeholder: UIImage? = nil) {
        self.image = placeholder
        self.currentURL = url
        
        ImageCacheManager.shared.downloadImage(with: url) { [weak self] downloadedImage in
            guard let self = self, let downloadedImage = downloadedImage else { return }
            DispatchQueue.main.async {
                if self.currentURL == url {
                    self.image = downloadedImage
                }
            }
        }
    }
}
