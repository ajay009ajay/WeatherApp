//
//  ImageCacheManager.swift
//  WeatherApp
//
//  Created by Ajay Kumar Singh on 08/04/25.
//

import SwiftUI
import Combine

class ImageCacheManager: ObservableObject {
    private let cache = NSCache<NSString, UIImage>()

    static let shared = ImageCacheManager()  // Singleton instance

    private init() {}

    // Check if the image is cached
    func getImage(for url: URL) -> UIImage? {
        return cache.object(forKey: url.absoluteString as NSString)
    }

    // Cache the image
    func cacheImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url.absoluteString as NSString)
    }
}
