import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private let disposeBag = DisposeBag()
    private var appCoordinator: AppCoordinator!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
 
        appCoordinator = AppCoordinator(window: window!)
        appCoordinator
            .start()
            .subscribe()
            .disposed(by: disposeBag)
        
        
        return true
    }


}

