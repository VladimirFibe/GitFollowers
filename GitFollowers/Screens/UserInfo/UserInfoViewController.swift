import UIKit

final class UserInfoViewController: UIViewController {

    private let headerView = UIView()
    private let middleView = UIView()
    private let bottomView = UIView()

    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupViews()
        getUserInfo()
    }

    private func setupNavigationBar() {
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonHandler)
        )
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.title = username
    }

    @objc func doneButtonHandler() {
        dismiss(animated: true)
    }

    private func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(child: UserInfoHeaderViewController(user: user), to: self.headerView)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(
                    title: "Something went wrong",
                    message: error.localizedDescription
                )
            }
        }
    }

    private func add(child: UIViewController, to container: UIView) {
        addChild(child)
        container.addSubview(child.view)
        child.view.frame = container.bounds
        child.didMove(toParent: self)
    }

    private func setupViews() {
        let padding = 20.0
        middleView.backgroundColor = .systemPink
        bottomView.backgroundColor = .systemBlue
        [headerView, middleView, bottomView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding).isActive = true
        }

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),

            middleView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            middleView.heightAnchor.constraint(equalToConstant: 180),

            bottomView.topAnchor.constraint(equalTo: middleView.bottomAnchor, constant: padding),
            bottomView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
}
