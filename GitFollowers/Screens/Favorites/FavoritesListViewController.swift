import UIKit

final class FavoritesListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let message = "где подписчики?"
        self.showEmptyStateView(with: message, in: self.view)
    }
}
