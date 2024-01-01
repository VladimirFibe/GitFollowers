import UIKit

class GFItemInfoViewController: UIViewController {
    public let stackView    = UIStackView()
    public let leftItem     = GFItemInfoView()
    public let rightItem    = GFItemInfoView()
    public let actionButton = GFButton()

    let user: User

    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    func setupViews() {
        view.layer.cornerRadius = 18
        view.backgroundColor    = .secondarySystemBackground
        view.addSubview(stackView)
        view.addSubview(actionButton)
        stackView.addArrangedSubview(leftItem)
        stackView.addArrangedSubview(rightItem)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
    }

    private func setupConstraints() {
        let padding = 20.0
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            actionButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            actionButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
