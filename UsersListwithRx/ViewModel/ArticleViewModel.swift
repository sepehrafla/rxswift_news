
import Foundation
import RxSwift
import RxCocoa

struct ArticleDetailModel {
    var articleData = ArticleDetail(title: "sample_news", description: "abc", urlToImage: "", content:"abc")
    var isFavorite: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var isFavObservable: Observable<Bool> {
        return isFavorite.asObservable()
    }
}

class ArticleViewModel {
    
    let request = APIRequest()
    var articles: Observable<[ArticleDetail]>?
    let articleViewModel = BehaviorRelay<[ArticleDetailModel]>(value: [])
    var articleViewModelObserver: Observable<[ArticleDetailModel]> {
        return articleViewModel.asObservable()
    }
    
    private let disposeBag = DisposeBag()
    
    func fetchUserList() {
        articles = request.callAPI()
        articles?.subscribe(onNext: { (value) in
            var userViewModelArray = [ArticleDetailModel]()
            for index in 0..<value.count {
                var user = ArticleDetailModel()
                user.articleData = value[index]
                userViewModelArray.append(user)
            }
            self.articleViewModel.accept(userViewModelArray)
        }, onError: { (error) in
            _ = self.articleViewModel.catchError { (error) in
                Observable.empty()
            }
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
}
