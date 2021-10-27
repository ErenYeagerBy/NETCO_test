import UIKit

struct NewsCollectionViewFlowLayoutType {
    
    private var viewFrame: CGRect = .zero
    
    var itemsPerRow: CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                return 2
            default:
                return 1
        }
    }
    
    var sectionInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 2.0, left: 2.0, bottom: 2.0, right: 2.0)
    }
    
    var sizeForItem: CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = viewFrame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = 9 * widthPerItem / 32
        switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                return CGSize(width: widthPerItem, height: widthPerItem * 0.9)
            default:
                return CGSize(width: widthPerItem, height: heightPerItem)
        }

    }
    
    init(frame: CGRect) {
        self.viewFrame = frame
    }
}
