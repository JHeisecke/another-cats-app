//
//  ImageManager.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-05.
//

import Foundation
import SDWebImage

struct ImageManager {

    private let prefetcher = SDWebImagePrefetcher()

    func startPrefetching(urls: [URL]) {
        prefetcher.prefetchURLs(urls)
    }

    func stopPrefetching() {
        prefetcher.cancelPrefetching()
    }

    func removeImage(urlString: String) {
        SDImageCache.shared.removeImage(forKey: urlString, fromDisk: true)
    }

}
