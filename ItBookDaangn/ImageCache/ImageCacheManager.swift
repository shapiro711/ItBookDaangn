//
//  ImageCacheManager.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/19/24.
//

import UIKit
import CommonCrypto

/**
 이미지 캐싱을 관리하는 Manager 객체
 
 - Note: memory, disck, download 순서로 진행
 - Date: 2023. 03. 19
 - Authors: 김도형
 */

final class ImageCacheManager {
    //MARK: - Property
    static let shared = ImageCacheManager()
    
    private let memoryCache = NSCache<NSString, UIImage>()
    private var ongoingTasks: [URL: URLSessionDataTask] = [:]
    private let diskCacheFilePath = "ImageCache"

    //MARK: - Interface
    /// 외부에서 이미지 다운로드를 위해 사용하는 메서드
    func downloadImage(with url: URL, completion: @escaping (UIImage?) -> Void) {
        
        if let cachedImage = checkMemoryCache(for: url) {
            completion(cachedImage)
            return
        }

        let fileURL = diskCacheFileURL(for: url)
        if let diskImage = checkDiskCache(for: fileURL) {
            completion(diskImage)
            return
        }

        downloadImageFromNetwork(url: url, cacheFileURL: fileURL, completion: completion)
    }

    //MARK: - MemoryCache
    /// Memory Cache가 았는지 체크
    private func checkMemoryCache(for url: URL) -> UIImage? {
        return memoryCache.object(forKey: url.absoluteString as NSString)
    }
    
    //MARK: - DiskCache
    /// diskCacheFile 경로 생성
    private func diskCacheFileURL(for url: URL) -> URL {
        let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
            .appendingPathComponent(diskCacheFilePath)
        try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        return directory.appendingPathComponent(url.absoluteString)
    }

    /// Disk Cache가 있는지 체크
    private func checkDiskCache(for fileURL: URL) -> UIImage? {
        return UIImage(contentsOfFile: fileURL.path)
    }

    // MARK: - Download
    private func downloadImageFromNetwork(url: URL, cacheFileURL: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data,
                  let image = UIImage(data: data),
                  error == nil else {
                DispatchQueue.main.async { completion(nil) }
                return
            }

            self?.memoryCache.setObject(image, forKey: url.absoluteString as NSString)
            try? data.write(to: cacheFileURL)

            DispatchQueue.main.async { completion(image) }
            self?.ongoingTasks.removeValue(forKey: url)
        }
        ongoingTasks[url] = task
        task.resume()
    }
    
    private func cancelOngoingDownload(for url: URL) {
        ongoingTasks[url]?.cancel()
        ongoingTasks.removeValue(forKey: url)
    }
}
