//
//  Kingfisher+Extensions.swift
//  Infos
//
//  Created by Михаил Зиновьев on 31.03.2023.
//

import UIKit
import Kingfisher

public extension ImageCache {
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let key = url.absoluteString
        if imageCachedType(forKey: key) != .none {
            retrieveImage(forKey: key, options: nil, callbackQueue: .mainAsync) { (imageResult) in
                switch imageResult {
                case .success(let result):
                    completion(result.image)
                case .failure(_):
                    completion(nil)
                }
            }
        } else {
            ImageDownloader.default.downloadImage(with: url, options: nil, progressBlock: nil) { (imageLoadingResult) in
                DispatchQueue.main.async {
                    switch imageLoadingResult {
                    case .success(let result):
                        self.store(result.image, forKey: key)
                        completion(result.image)
                    case .failure(_):
                        completion(nil)
                    }
                }
            }
        }
    }
}
