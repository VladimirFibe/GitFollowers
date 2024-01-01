import UIKit

final class UserInfoViewController: UIViewController {

    private let headerView = UIView()

    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonHandler))
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.title = username
        setupViews()
        NetworkManager.shared.getUserInfo(for: username) { result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(child: UserInfoHeaderViewController(user: user), to: self.headerView)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    @objc func doneButtonHandler() {
        dismiss(animated: true)
    }

    private func add(child: UIViewController, to container: UIView) {
        addChild(child)
        container.addSubview(child.view)
        child.view.frame = container.bounds
        child.didMove(toParent: self)
    }

    private func setupViews() {
        [headerView].forEach { view.addSubview($0)}
        headerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
}
