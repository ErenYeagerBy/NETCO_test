import Foundation
import RxCocoa
import RxSwift

class LoadingViewModel {
    var showNextVC = PublishRelay<[DataModel]>()
    let disposeBag = DisposeBag()
    
    func loadNewsData(completion: @escaping ([DataModel]) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            NetworkManager.shared.loadData(url: Constants.url) { postsData in
                completion(postsData)
            }
        }
    }
}
