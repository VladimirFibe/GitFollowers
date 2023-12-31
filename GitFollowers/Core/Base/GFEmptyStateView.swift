import UIKit

final class GFEmptyStateView: UIView {

    private let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    private let logoImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(message: String) {
        super.init(frame: .zero)
        configure()
        messageLabel.text = message
    }

    private func configure() {
        addSubview(messageLabel)
        addSubview(logoImageView)
        messageLabel.numberOfLines  = 3
        messageLabel.textColor      = .secondaryLabel
        logoImageView.image         = .emptyStateLogo
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),

            logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 200),
            logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 140)
        ])
    }
}
