import UIKit

enum ItemInfoType {
    case repos, gists, followers, following

    var icon: String {
        switch self {
        case .repos:        SFSymbols.repos
        case .gists:        SFSymbols.gitsts
        case .followers:    SFSymbols.followers
        case .following:    SFSymbols.following
        }
    }
    
    var title: String {
        switch self {
        case .repos:        "Public Repos"
        case .gists:        "Public Gists"
        case .followers:    "Followers"
        case .following:    "Following"
        }
    }
}

class GFItemInfoView: UIView {
    private let symbolImageView = UIImageView()
    private let titleLabel      = GFTitleLabel(textAlignment: .left, fontSize: 14)
    private let countLabel      = GFTitleLabel(textAlignment: .center, fontSize: 14)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: ItemInfoType, value: Int) {
        countLabel.text = String(value)
        symbolImageView.image = UIImage(systemName: item.icon)
        titleLabel.text = item.title
    }

    private func configure() {
        [symbolImageView, titleLabel, countLabel].forEach { addSubview($0)}
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label

        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalTo: symbolImageView.widthAnchor),

            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            countLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
