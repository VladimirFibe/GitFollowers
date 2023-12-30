import UIKit

extension UIViewController {
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
}
