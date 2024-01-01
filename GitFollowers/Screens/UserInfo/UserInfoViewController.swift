import UIKit

protocol UserInfoDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

final class UserInfoViewController: UIViewController {

    private let headerView  = UIView()
    private let middleView  = UIView()
    private let bottomView  = UIView()
    private let dateLabel   = GFBodyLabel(textAlignment: .center)
    var username: String!
    weak var delegate: FollowerListDelegate?

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
        NetworkManager.shared.getUserInfo(for: username) {[weak self] result in
            guard let self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configure(with: user) }
            case .failure(let error):
                self.presentGFAlertOnMainThread(
                    title: "Something went wrong",
                    message: error.rawValue
                )
            }
        }
    }

    private func configure(with user: User) {

        let repoViewController          = UserReposViewController(user: user)
        repoViewController.delegate     = self
        let followerViewControler       = UserFollowersViewController(user: user)
        followerViewControler.delegate  = self
        
        self.add(child: UserInfoHeaderViewController(user: user), to: self.headerView)
        self.add(child: repoViewController, to: self.middleView)
        self.add(child: followerViewControler, to: self.bottomView)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertToDisplayFormat())"
    }

    private func add(child: UIViewController, to container: UIView) {
        addChild(child)
        container.addSubview(child.view)
        child.view.frame = container.bounds
        child.didMove(toParent: self)
    }

    private func setupViews() {

        let padding = 20.0
        [headerView, middleView, bottomView, dateLabel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding).isActive = true
        }

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),

            middleView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            middleView.heightAnchor.constraint(equalToConstant: 140),

            bottomView.topAnchor.constraint(equalTo: middleView.bottomAnchor, constant: padding),
            bottomView.heightAnchor.constraint(equalToConstant: 140),

            dateLabel.topAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: padding),
        ])
    }
}

extension UserInfoViewController: UserInfoDelegate {
    func didTapGitHubProfile(for user: User) {
        presentSafari(with: user.htmlUrl)
    }

    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(
                title: "No followers",
                message: "This user has no followers. What a shame😞.",
                buttonTitle: "So sad"
            )
            return
        }
        delegate?.didRequestFollowers(for: user.login)
        dismiss(animated: true)
    }
}
