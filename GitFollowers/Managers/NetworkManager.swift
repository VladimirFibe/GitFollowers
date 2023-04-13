import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com/users"
    private init() {}
    
    func getFollowers(for username: String, page: Int, completion: @escaping ([Follower]?, String?) -> Void) {
        let endpoint = baseURL + "/\(username)/followers?per_page=100&page=\(page)"
        print(endpoint)
        guard let url = URL(string: endpoint) else {
            completion(nil, "This username created an invalid request. Please try again.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, "This username created an invalid request& Please try again")
                print(error.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse,
            response.statusCode == 200 else {
                completion(nil, "Invalid response from the server. Please try again.")
                return
            }
            guard let data = data else {
                completion(nil, "The data received from the server was invalid. Please try again.")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(followers, nil)
            } catch {
                completion(nil, "decoding error")
            }
        }
        task.resume()
    }
}
