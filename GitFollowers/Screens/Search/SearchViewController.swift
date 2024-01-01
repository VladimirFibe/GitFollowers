import UIKit

final class SearchViewController: UIViewController {
    let padding = 50.0
    let logoImageView       = UIImageView()
    let usernameTextField   = GFTextField()
    let callToActionButton  = GFButton(
        backgroundColor: .accent,
        title: "Get Followers"
    )
    var isUsernameEntered: Bool { !(usernameTextField.text?.isEmpty ?? true) }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        createDismissKeyboardTapGesture()
        configureLogoImageView()
        configureTextField()
        configureButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowersListViewController() {
        guard isUsernameEntered else {
            presentGFAlertOnMainThread(
                title: "Empty Username",
                message: "Please, enter a username. We need to know who to look for 😀"
            )
            return
        }
        let viewController = FollowersListViewController()
        viewController.username = usernameTextField.text
        usernameTextField.text = ""
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = .ghLogo
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor),
        ])
    }
    
    private func configureTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: padding),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            view.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor, constant: padding),
            usernameTextField.heightAnchor.constraint(equalToConstant: padding)
        ])
    }
    
    private func configureButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(
            self,
            action: #selector(pushFollowersListViewController),
            for: .primaryActionTriggered
        )
        NSLayoutConstraint.activate([
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: callToActionButton.bottomAnchor, constant: padding),
            callToActionButton.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            callToActionButton.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            callToActionButton.heightAnchor.constraint(equalToConstant: padding)
        ])
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersListViewController()
        return true
    }
}
