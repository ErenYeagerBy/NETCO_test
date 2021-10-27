import UIKit

class ImageViewsBuilder {
    
    enum ImageViewType {
        case postImage
    }
    
    func build(_ type: ImageViewType) -> UIImageView {
        switch type {
            case .postImage:
                return UIImageView.build { imageView in
                    imageView.contentMode = .scaleAspectFill
                    imageView.clipsToBounds = true
                }
        }
    }
}

extension UIImageView {
    static func build(block: (UIImageView) -> ()) -> UIImageView {
        let imageView = UIImageView()
        block(imageView)
        return imageView
    }
}
