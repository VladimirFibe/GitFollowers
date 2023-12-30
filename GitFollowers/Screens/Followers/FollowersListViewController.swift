import UIKit

class FollowersListViewController: UIViewController {
    enum Section { case main }

    var username: String!
    var followers: [Follower] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
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
        collectionView.register(
            FollowerCollectionViewCell.self,
            forCellWithReuseIdentifier: FollowerCollectionViewCell.identifier
        )
    }
    
    private func getFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) {[weak self] result in
            guard let self else { return }
            switch result {
            case .success(let followers):
                DispatchQueue.main.async {
                    self.followers = followers
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
