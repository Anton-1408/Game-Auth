import Foundation
import SwiftUI

final class AuthRouter: ObservableObject {
    static let shared = AuthRouter()
    
    @Published var path = [AuthRoute]()
    
    func goToTheWaitingRoom() {
        path.append(AuthRoute.waitingRoom)
    }
    
    func goToTheBarRoom() {
        path.append(AuthRoute.barRoom)
    }
    
    func goToTheGameRoom() {
        path.append(AuthRoute.gameRoom)
    }
    
    func back() {
        path.removeLast()
    }
    
    func goToRoot () {
        path.removeAll()
    }
}
