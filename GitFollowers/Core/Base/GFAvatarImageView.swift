import UIKit

final class GFAvatarImageView: UIImageView {
    let cache               = NetworkManager.shared.cache
    let placeHolderImage    = UIImage.avatarPlaceholder
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = .avatarPlaceholder
        translatesAutoresizingMaskIntoConstraints = false
    }

    func downloadImage(from urlString: String) {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
        } else {
            guard let url = URL(string: urlString) else { return }
            let task = URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
                guard let self else { return }
                guard error == nil else { return }
                guard let response = response as? HTTPURLResponse,
                      response.statusCode == 200 else { return }
                guard let data else { return }
                guard let image = UIImage(data: data) else { return }
                self.cache.setObject(image, forKey: cacheKey)
                DispatchQueue.main.async { self.image = image }
            }
            task.resume()
        }
    }
}
