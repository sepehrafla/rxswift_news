

import Foundation

struct DataModel : Codable {
    let articles: [ArticleDetail]
}

struct ArticleDetail : Codable{
    let title : String?
    let description : String?
    let urlToImage : String?
    let content : String?
}
