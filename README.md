# [CacheExample](https://www.youtube.com/watch?v=Nm9sXBSHZsI)
NSCache to make your app more snappy and performant. 
<img width="516" src="https://user-images.githubusercontent.com/47273077/159114803-1a4fa0aa-7d77-4420-b340-e34941f42bc6.png">

<img width="693" src="https://user-images.githubusercontent.com/47273077/159114567-3235c707-fe0f-4731-bd2a-5b9db77f1d1f.png">

<img width="516" src="https://user-images.githubusercontent.com/47273077/159114803-1a4fa0aa-7d77-4420-b340-e34941f42bc6.png">

ImageProvider
```swift

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

```

SecondVC
```swift
import UIKit

class SecondVC: UIViewController {
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        ImageProvider.shared.fetchImage { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
    }
}
```
