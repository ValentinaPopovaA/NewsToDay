//
//  ImageLoader.swift
//  NewsToDay
//
//  Created by Валентина Попова on 22.10.2024.
//

import UIKit

class ImageLoader {
    
    static let shared = ImageLoader()
    private var imageCache = NSCache<NSURL, UIImage>()
    
    private init() {}
    
    // Асинхронная загрузка изображения с кэшированием
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let nsUrl = url as NSURL
        
        if let cachedImage = imageCache.object(forKey: nsUrl) {
            completion(cachedImage)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                self.imageCache.setObject(image, forKey: nsUrl)
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}
