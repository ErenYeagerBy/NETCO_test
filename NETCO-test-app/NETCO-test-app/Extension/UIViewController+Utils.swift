import UIKit

extension UIViewController {
    func showAlert(title: String? = nil,
                   message: String? = nil,
                   actionTitle: String? = nil,
                   cancelTitle: String? = nil,
                   textField: UITextField? = nil,
                   cancelHandler: ((UIAlertAction) ->())? = nil,
                   actionHandler: ((UIAlertAction) -> ())? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if actionTitle != nil {
            alertController.addAction(UIAlertAction(title: actionTitle, style: .default, handler: actionHandler))
        }
        if cancelTitle != nil {
            alertController.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        }
        if textField != nil {
            alertController.addTextField { (textField) in
                textField.placeholder = ""
                textField.borderStyle = .line
            }
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
