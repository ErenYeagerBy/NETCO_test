import UIKit
import TinyConstraints
import Reachability

class PostDetailsViewController: UIViewController {
    
    private lazy var postBodyTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        textView.textColor = .black
        textView.textAlignment = .left
        textView.backgroundColor = .white
        textView.isEditable = false
        textView.sizeToFit()
        return textView
    }()
    
    private lazy var postImageView = ImageViewsBuilder().build(.postImage)
    private lazy var postHeaderLabel = LabelsBuilder().build(.postDetailsHeaderLabel)
    private var postData: DataModel
    
    init(postData: DataModel) {
        self.postData = postData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        configureImageView()
        configureHeaderLabel()
        configureTextView()
    }
    
    private func configureImageView() {
        view.addSubview(postImageView)
        postImageView.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        postImageView.height(view.frame.width * 9 / 16)
        NetworkManager.shared.getImage(url: postData.imageUrl) { image in
            DispatchQueue.main.async {
                self.postImageView.image = image
            }
        }
    }
    
    private func configureHeaderLabel() {
        view.addSubview(postHeaderLabel)
        postHeaderLabel.edgesToSuperview(excluding: [.top, .bottom], insets: .left(5) + .right(5))
        postHeaderLabel.topToBottom(of: postImageView).constant = 15
        //postHeaderLabel.height(27)
        postHeaderLabel.text = postData.headLineText
    }
    
    private func configureTextView() {
        view.addSubview(postBodyTextView)
        postBodyTextView.edgesToSuperview(excluding: .top, insets: .left(5) + .right(5), usingSafeArea: true)
        postBodyTextView.topToBottom(of: postHeaderLabel).constant = 7
        postBodyTextView.text = postData.bodyText.htmlStripped
    }
    
}
