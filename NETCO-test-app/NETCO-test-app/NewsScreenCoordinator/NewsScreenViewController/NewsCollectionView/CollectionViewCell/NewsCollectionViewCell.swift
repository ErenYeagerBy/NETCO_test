import UIKit
import TinyConstraints

class NewsCollectionViewCell: UICollectionViewCell {
    
    lazy var headLineLabel = LabelsBuilder().build(.headLine)
    lazy var descriptionLabel = LabelsBuilder().build(.descriptionLabel)
    lazy var postImageView = ImageViewsBuilder().build(.postImage)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }
    
    private func configureUI() {
        configurePostImageView()
        configureDescriptionLabel()
        configureHeadLineLabel()
    }
    
    private func configurePostImageView() {
        contentView.addSubview(postImageView)
        switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                postImageView.edgesToSuperview(excluding: .bottom)
                postImageView.height(frame.width * 9 / 16)
            default:
                postImageView.edgesToSuperview(excluding: [.right])
                postImageView.width(frame.width / 2)
        }
    }
    
    private func configureHeadLineLabel() {
        contentView.addSubview(headLineLabel)
        switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                headLineLabel.edgesToSuperview(excluding: [.top], insets: .left(2) + .right(2) + .bottom(2))
                headLineLabel.topToBottom(of: descriptionLabel).constant = 10
            default:
                headLineLabel.edgesToSuperview(excluding: [.left, .top], insets: .right(2) + .bottom(2))
                headLineLabel.leftToRight(of: postImageView).constant = 5
                headLineLabel.topToBottom(of: descriptionLabel).constant = 7
        }
    }
    
    private func configureDescriptionLabel() {
        contentView.addSubview(descriptionLabel)
        switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                descriptionLabel.edgesToSuperview(excluding: [.top, .bottom], insets: .left(2) + .right(2))
                descriptionLabel.topToBottom(of: postImageView).constant = 10
            default:
                descriptionLabel.edgesToSuperview(excluding: [.left, .bottom], insets: .top(2) + .right(2))
                descriptionLabel.leftToRight(of: postImageView).constant = 5
        }
        descriptionLabel.height(18)
    }
    
}
