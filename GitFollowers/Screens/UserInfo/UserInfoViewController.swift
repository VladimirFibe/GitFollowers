import UIKit

final class UserInfoViewController: UIViewController {
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonHandler))
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.title = username
    }

    @objc func doneButtonHandler() {
        dismiss(animated: true)
    }
}
