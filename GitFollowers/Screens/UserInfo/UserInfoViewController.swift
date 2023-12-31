import UIKit

final class UserInfoViewController: UIViewController {
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonHandler))
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.title = username
        NetworkManager.shared.getUserInfo(for: username) { result in
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    @objc func doneButtonHandler() {
        dismiss(animated: true)
    }
}
