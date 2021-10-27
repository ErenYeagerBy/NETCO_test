import UIKit
import TinyConstraints
import Reachability

class LoadingViewController: UIViewController {
    
    private lazy var loadingLabel = LabelsBuilder().build(.loadingLabel)
    private lazy var spinner: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .medium
        activityIndicator.color = .gray
        return activityIndicator
    }()
    
    var viewModel: LoadingViewModel
    
    init(viewModel: LoadingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        spinner.startAnimating()
        viewModel.loadNewsData { [weak self] postsData in
            self?.viewModel.showNextVC.accept(postsData)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkInternetConnection()
    }
    
    private func setupUI() {
        view.backgroundColor = .yellow
        configureLoadingLabel()
        configureSpinner()
    }
    
    private func configureLoadingLabel() {
        view.addSubview(loadingLabel)
        loadingLabel.centerInSuperview()
    }
    
    private func configureSpinner() {
        view.addSubview(spinner)
        spinner.centerXToSuperview()
        spinner.topToBottom(of: loadingLabel).constant = 15
    }
    
    private func checkInternetConnection() {
        guard try! Reachability().connection != Reachability.Connection.unavailable else {
            self.showAlert(title: "No Internet connection!", message: "Please check your Internet connection!", actionTitle: "OK")
            spinner.stopAnimating()
            return
        }
    }
}
