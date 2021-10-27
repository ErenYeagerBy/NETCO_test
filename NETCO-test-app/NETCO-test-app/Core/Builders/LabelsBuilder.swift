import UIKit

class LabelsBuilder {
    
    enum LabelType {
        case loadingLabel
        case headLine
        case descriptionLabel
        case postDetailsHeaderLabel
    }
    
    func build(_ type: LabelType) -> UILabel {
        switch type {
            case .headLine:
                return UILabel.build { label in
                    label.numberOfLines = 0
                    label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
                    label.textAlignment = .left
                    label.textColor = .black
                    label.numberOfLines = 0
                    label.adjustsFontSizeToFitWidth = true
                    label.minimumScaleFactor = 0.6
                    label.sizeToFit()
                }
            case .descriptionLabel:
                return UILabel.build { label in
                    label.numberOfLines = 0
                    label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
                    label.textAlignment = .left
                    label.textColor = .gray
                    label.adjustsFontSizeToFitWidth = true
                    label.minimumScaleFactor = 0.6
                }
            case .postDetailsHeaderLabel:
                return UILabel.build { label in
                    label.numberOfLines = 1
                    label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
                    label.textAlignment = .left
                    label.textColor = .black
                    label.adjustsFontSizeToFitWidth = true
                    label.minimumScaleFactor = 0.6
                    label.numberOfLines = 0
                }
            case .loadingLabel:
                return UILabel.build { label in
                    label.numberOfLines = 1
                    label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
                    label.textAlignment = .center
                    label.textColor = .black
                    label.adjustsFontSizeToFitWidth = true
                    label.minimumScaleFactor = 0.6
                    label.text = "Loading news..."
                }
        }
    }
}

extension UILabel {
    static func build(block: (UILabel) -> ()) -> UILabel {
        let label = UILabel()
        block(label)
        return label
    }
}
