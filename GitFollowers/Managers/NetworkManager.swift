import UIKit

final class NetworkManager {
    static let shared   = NetworkManager()
    private let baseURL = "https://api.github.com/users"
    let cache           = NSCache<NSString, UIImage>()
    private init() {}
    
    func getFollowers(
        for username: String,
        perPage: Int,
        page: Int,
        completion: @escaping (Result<[Follower], GFError>) -> Void
    ) {
        let endpoint = baseURL + "/\(username)/followers?per_page=\(perPage)&page=\(page)"
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.unableToComplete))
                print(error.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse,
            response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(.success(followers))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }

    func getUserInfo(
        for username: String,
        completion: @escaping (Result<User, GFError>) -> Void
    ) {
        let endpoint = baseURL + "/\(username)"
        print("DEBUG: ", endpoint)
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUsername))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.unableToComplete))
                print(error.localizedDescription)
                return
            }

            guard let response = response as? HTTPURLResponse,
            response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)
                completion(.success(user))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }

}
