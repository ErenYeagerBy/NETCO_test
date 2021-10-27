import Foundation
import RxSwift

class AppCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() ->  Observable<Void> {
        let nextCoordinator = LoadingCoordinator(window: window)
        return coordinate(to: nextCoordinator)
    }
    
}
