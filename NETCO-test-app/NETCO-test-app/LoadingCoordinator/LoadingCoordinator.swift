import UIKit
import RxCocoa
import RxSwift

class LoadingCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        
        let viewModel = LoadingViewModel()
        let viewController = LoadingViewController(viewModel: viewModel)
        
        viewModel.showNextVC
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                self?.handleNextCoordinator(result)
            }).disposed(by: disposeBag)
        
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
    
    private func handleNextCoordinator(_ result: [DataModel]) {
        coordinate(to: NewsScreenCoordinator(window: window, postsData: result))
    }
}
