

import Foundation
import RxCocoa
import RxSwift

protocol APIRequestProtocol {
     func callAPI<T: Codable>() -> Observable<T>
}

class APIRequest: APIRequestProtocol {
    var baseURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=6d1c913a9cff427da937eec5bbac9f24")!
    let session = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask? = nil
    
    func changebaseurl (url : String){
        baseURL = URL(string:url)!
    }
    
    func callAPI<T: Codable>() -> Observable<T> {
        //create an observable and emit the state as per response.
        return Observable<T>.create { observer in
            self.dataTask = self.session.dataTask(with: self.baseURL, completionHandler: { (data, response, error) in
                do {
                    let model: DataModel = try JSONDecoder().decode(DataModel.self, from: data ?? Data())
                    observer.onNext(model.articles as! T)
                } catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
            })
            self.dataTask?.resume()
            return Disposables.create {
                self.dataTask?.cancel()
            }
        }
    }
}
