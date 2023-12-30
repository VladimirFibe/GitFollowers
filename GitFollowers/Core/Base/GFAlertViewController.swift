import UIKit

class GFAlertViewController: UIViewController {

    let containerView   = UIView()
    let titleLabel      = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel    = GFBodyLabel(textAlignment: .center)
    let actionButton    = GFButton(backgroundColor: .systemPink, title: "Ok")
    let padding         = 20.0
    var alterTitle: String?
    var message: String?
    var buttonTitle: String?
    
    init(
        alterTitle: String? = nil,
        message: String? = nil,
        buttonTitle: String? = nil
    ) {
        super.init(nibName: nil, bundle: nil)
        self.alterTitle     = alterTitle
        self.message        = message
        self.buttonTitle    = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .alertBackground
        configureContainerView()
        configureTitleLabel()
        configureMessageLabel()
        configureActionButton()
    }
    
    private func configureContainerView() {
        view.addSubview(containerView)
        containerView.layer.cornerRadius    = 16
        containerView.layer.borderWidth     = 2
        containerView.layer.borderColor     = UIColor.white.cgColor
        containerView.backgroundColor       = .systemBackground
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    private func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alterTitle ?? "Something went wrong"
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    private func configureMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.text           = message ?? "Unable to complete request"
        messageLabel.numberOfLines  = 4
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
        ])
    }
    
    private func configureActionButton() {
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissCGAlert), for: .primaryActionTriggered)
        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 12),
            actionButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            actionButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc private func dismissCGAlert() {
        dismiss(animated: true)
    }
}
