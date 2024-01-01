import UIKit

class GFItemInfoViewController: UIViewController {
    public let stackView    = UIStackView()
    public let leftItem     = GFItemInfoView()
    public let rightItem    = GFItemInfoView()
    public let actionButton = GFButton()

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
        leftItem.configure(with: .repos, value: 5)
        rightItem.configure(with: .gists, value: 7)
        actionButton.backgroundColor = .systemPink
        actionButton.setTitle("click me", for: [])
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
            actionButton.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
