import UIKit

final class UserFollowersViewController: GFItemInfoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        leftItem.configure(with: .followers, value: user.followers)
        rightItem.configure(with: .following, value: user.following)
        actionButton.configure(with: "Get Followers", backgroundColor: .systemGreen)
    }
}
