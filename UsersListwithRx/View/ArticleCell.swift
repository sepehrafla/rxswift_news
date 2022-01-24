

import UIKit

class ArticleCell: UITableViewCell {
    
    static let starTintColor = UIColor(red: 212/255, green: 163/255, blue: 50/255, alpha: 1.0)
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionlabel: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    
    func configureCell(userDetail: ArticleDetailModel) {
        title.text = userDetail.articleData.title ?? ""
        descriptionlabel.text = userDetail.articleData.description ?? ""
        if userDetail.isFavorite.value {
            favoriteImage.image = UIImage(systemName: "star.fill")?.withTintColor(ArticleCell.starTintColor)
        } else {
            favoriteImage.image = UIImage(systemName: "star")?.withTintColor(ArticleCell.starTintColor)
        }
    }
    
}
