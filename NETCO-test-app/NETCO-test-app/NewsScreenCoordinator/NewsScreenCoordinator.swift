import UIKit
import RxSwift
import RxCocoa

class NewsScreenCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    private var navigationController: UINavigationController?
    private let postsData: [DataModel]
    
    init(window: UIWindow, postsData: [DataModel]) {
        self.window = window
        self.postsData = postsData
    }
    
    override func start() -> Observable<Void> {
        
        let viewController = NewsScreenViewController(postsData: postsData)
        navigationController = UINavigationController(rootViewController: viewController)
        navigationController?.isNavigationBarHidden = true
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
    
}
