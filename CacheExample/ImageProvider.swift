//
//  ImageProvider.swift
//  CacheExample
//
//  Created by 山本響 on 2022/03/19.
//

import UIKit

class ImageProvider {
    static let shared = ImageProvider()
    
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    public func fetchImage(
        completion: @escaping (UIImage?) -> Void) {
            
            if let image = cache.object(forKey: "image") {
                print("using cache")
                completion(image)
                return
            }
        
            guard let url = URL(string: "https://source.unsplash.com/random/500x500") else {
                return
            }
            print("Fetching image")
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                
                guard let data = data, error == nil else {
                    completion(nil)
                    return
                }
                
                DispatchQueue.main.async {
                    guard let image = UIImage(data: data) else {
                        completion(nil)
                        return
                    }
                    self?.cache.setObject(image, forKey: "image")
                    completion(image)
                }
                
            }
            task.resume()
    }
}
