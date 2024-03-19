//
//  UIImageView + Download.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/19/24.
//

import UIKit

extension UIImageView {
    func setImage(from url: URL, placeholder: UIImage? = nil) {
        self.image = placeholder
        ImageCacheManager.shared.downloadImage(with: url) { [weak self] downloadedImage in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.image = downloadedImage
            }
        }
    }
}
