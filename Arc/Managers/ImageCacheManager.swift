//
//  ImageCacheManager.swift
//  Arc
//
//  Created by Ahmed El Gndy on 01/05/2025.
//

import UIKit

class ImageCacheManager{
    static let shared = ImageCacheManager()
    private init(){}
    
    private let cache = NSCache<NSString, UIImage>()

    func image(for url:String )-> UIImage?{
        let cachekey = NSString(string: url)
        return cache.object(forKey: cachekey)
    }
    
    func cache(_ image : UIImage, forkey url: String) {
        cache.setObject(image, forKey: url as NSString)
    }
}

