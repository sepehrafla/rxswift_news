

import UIKit
import RxSwift
import RxCocoa

class ArticleDetailViewController: UIViewController {
    
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var image : UIImageView!
    
    private let disposeBag = DisposeBag()
    var articleDetail = BehaviorRelay<ArticleDetailModel>(value: ArticleDetailModel())
    var articleDetailObserver: Observable<ArticleDetailModel> {
        return articleDetail.asObservable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Bind button tap via rx
        favoriteButton.rx.tap.bind {
            let favValue = self.articleDetail.value.isFavorite
            favValue.accept(!favValue.value)
        }.disposed(by: disposeBag)
        
        articleDetailObserver.subscribe(onNext: { (userValue) in
            self.title = "\(userValue.articleData.title ?? "")'s Details"
            self.content.text = "\(userValue.articleData.content ?? "")"
            let imageurl = userValue.articleData.urlToImage ?? "https://cdn.arstechnica.net/wp-content/uploads/2018/06/macOS-Mojave-Dynamic-Wallpaper-transition.jpg"
            let url = URL(string: imageurl)
            let data = try? Data(contentsOf: url!)
            self.image.image = UIImage(data: data!)
            self.setupFavoriteButtonImage(userValue: userValue)
            userValue.isFavObservable.subscribe(onNext: { (value) in
                self.setupFavoriteButtonImage(userValue: userValue)
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }
    
    func setupFavoriteButtonImage(userValue: ArticleDetailModel) {
        if userValue.isFavorite.value {
            favoriteButton.setImage(UIImage(systemName: "star.fill")?.withTintColor(ArticleCell.starTintColor), for: .normal)
        } else{
            favoriteButton.setImage(UIImage(systemName: "star")?.withTintColor(ArticleCell.starTintColor), for: .normal)
        }
    }
}
