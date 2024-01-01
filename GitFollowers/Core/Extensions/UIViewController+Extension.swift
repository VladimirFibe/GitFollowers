import UIKit
import SafariServices

fileprivate var containerView: UIView!
extension UIViewController {
    func presentSafari(with url: String) {
        guard let url = URL(string: url) else {
            presentGFAlertOnMainThread(title: "Invalid URL")
            return
        }
        let controller = SFSafariViewController(url: url)
        controller.preferredControlTintColor = .accent
        present(controller, animated: true)
    }
    func presentGFAlertOnMainThread(
        title: String? = nil,
        message: String? = nil,
        buttonTitle: String? = nil
    ) {
        DispatchQueue.main.async {
            let alert = GFAlertViewController(
                alterTitle: title,
                message: message,
                buttonTitle: buttonTitle
            )
            alert.modalPresentationStyle = .overFullScreen
            alert.modalTransitionStyle = .crossDissolve
            self.present(alert, animated: true)
        }
    }

    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        activityIndicator.startAnimating()
    }

    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }

    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
