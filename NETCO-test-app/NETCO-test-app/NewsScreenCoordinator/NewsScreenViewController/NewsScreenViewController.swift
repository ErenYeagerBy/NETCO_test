import UIKit
import TinyConstraints
import Reachability

class NewsScreenViewController: UIViewController {
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private var postsData: [DataModel]
    private var newsCollectionViewAdapter: NewsCollectionViewAdapter?
    
    init(postsData: [DataModel]) {
        self.postsData = postsData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func configureCollectionView() {
        newsCollectionViewAdapter = NewsCollectionViewAdapter(with: collectionView, dataSource: postsData)
        collectionView.delegate = newsCollectionViewAdapter
        collectionView.dataSource = newsCollectionViewAdapter
        view.addSubview(collectionView)
        collectionView.edgesToSuperview(usingSafeArea: true)
        newsCollectionViewAdapter?.cellTapCallback = { [weak self] post in
            self?.checkInternetConnection()
            let viewController = PostDetailsViewController(postData: post)
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    private func checkInternetConnection() {
        guard try! Reachability().connection != Reachability.Connection.unavailable else {
            self.showAlert(title: "No Internet connection!", message: "Please check your Internet connection!", actionTitle: "OK")
            return
        }
    }
}

