import UIKit

final class UserInfoHeaderViewController: UIViewController {
    private let avatarImageView     = GFAvatarImageView(frame: .zero)
    private let usernameLabel       = GFTitleLabel(textAlignment: .left, fontSize: 34)
    private let nameLabel           = GFSecondaryTitleLabel(fontSize: 18)
    private let locationImageView   = UIImageView()
    private let locationLabel       = GFSecondaryTitleLabel(fontSize: 18)
    private let bioLabel            = GFBodyLabel(textAlignment: .left)

    var user: User

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [
            avatarImageView,
            usernameLabel,
            nameLabel,
            locationImageView,
            locationLabel,
            bioLabel
        ].forEach { view.addSubview($0)}
    }

    private func setupViews() {
        view.backgroundColor = .systemBackground
        addSubviews()
        avatarImageView.downloadImage(from: user.avatarUrl)
        usernameLabel.text = user.login
        nameLabel.text = user.name ?? "No name"
        nameLabel.setContentHuggingPriority(.init(rawValue: 249), for: .vertical)
        locationLabel.text = user.location ?? "No Location"
        bioLabel.text = user.bio ?? "No bio available"
        bioLabel.numberOfLines = 3

        locationImageView.image = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor = .secondaryLabel
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupConstraints() {
        let textImagePadding: CGFloat   = 12

        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),

            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, 
                                                   constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            nameLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: locationLabel.topAnchor),

            locationImageView.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            locationImageView.centerYAnchor.constraint(equalTo: locationLabel.centerYAnchor),

            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalTo: locationImageView.widthAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, 
                                                   constant: textImagePadding),


            locationLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            locationLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),

            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
