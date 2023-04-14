import UIKit

class FollowersListViewController: UIViewController {
    var username: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            switch result {
            case .success(let followers): followers.forEach { print($0.login)}
            case .failure(let error): self.presentGFAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
