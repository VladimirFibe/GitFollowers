import UIKit

class FollowersListViewController: UIViewController {
    enum Section { case main }

    var username: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var page = 1
    let perPage = 100
    var hasMoreFollowers = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureViewController()
        configureCollectionView()
        getFollowers()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchBar.delegate     = self
        searchController.searchResultsUpdater   = self
        searchController.searchBar.placeholder  = "Search for a user"
        navigationItem.searchController         = searchController
    }

    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: UIHelper.createThreeColumnFlowLayout(width: view.bounds.width)
        )
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.register(
            FollowerCollectionViewCell.self,
            forCellWithReuseIdentifier: FollowerCollectionViewCell.identifier
        )
    }
    
    private func getFollowers() {
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, perPage: perPage, page: page) {[weak self] result in
            guard let self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let followers):
                self.hasMoreFollowers = followers.count == perPage
                page += 1
                DispatchQueue.main.async {
                    self.followers.append(contentsOf: followers)
                    self.updateData(on: followers)
                    if self.followers.isEmpty {
                        let message = "где подписчики?"
                        self.showEmptyStateView(with: message, in: self.view)
                    }
                }
            case .failure(let error): self.presentGFAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue)
            }
        }
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView) {
            collectionView,
            indexPath,
            follower in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FollowerCollectionViewCell.identifier,
                for: indexPath
            ) as? FollowerCollectionViewCell else {
                return FollowerCollectionViewCell()
            }
            cell.configure(with: follower)
            return cell
        }
    }
    
    private func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension FollowersListViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        if offsetY > contentHeight - height, hasMoreFollowers {
            getFollowers()

        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let follower  = dataSource.itemIdentifier(for: indexPath) else { return }
        let controller      = UserInfoViewController()
        controller.username = follower.login
        present(UINavigationController(rootViewController: controller), animated: true)
    }
}

extension FollowersListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text else { return }
        if filter.isEmpty {
            updateData(on: followers)
        } else {
            filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased())}
            updateData(on: filteredFollowers)
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: followers)
    }
}
