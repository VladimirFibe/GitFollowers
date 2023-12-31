import UIKit

class FollowersListViewController: UIViewController {
    enum Section { case main }

    var username: String!
    var followers: [Follower] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var page = 1
    let perPage = 100
    var hasMoreFollowers = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
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
                    self.updateData()
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
    
    private func updateData() {
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
}
