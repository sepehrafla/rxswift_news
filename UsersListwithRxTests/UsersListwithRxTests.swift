
import XCTest
import RxSwift
import RxCocoa

@testable import UsersListwithRx

class UsersListwithRxTests: XCTestCase {
    
    private var userViewModelInstance : ArticleViewModel!

    override func setUp() {
        super.setUp()
        
        self.userViewModelInstance = ArticleViewModel()
        
        self.userViewModelInstance.fetchUserList()
    
    }
}
    
    
    
    
//    func test_should_be_able_to_fetch_the_data_successfully() {
//        let userViewModel_samle = BehaviorRelay<[UserDetailModel]>(value: [])
//
//        XCTAssertEqual(userViewModelInstance.userViewModel, userViewModel_samle)
//        }
//        
//    }
