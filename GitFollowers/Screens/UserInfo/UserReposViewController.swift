import UIKit

final class UserReposViewController: GFItemInfoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        leftItem.configure(with: .repos, value: user.publicRepos)
        rightItem.configure(with: .gists, value: user.publicGists)
        actionButton.configure(with: "GitHub Profile", backgroundColor: .systemPurple)
    }

    override func actionHandler() {
        delegate?.didTapGitHubProfile(for: user)
    }
}
