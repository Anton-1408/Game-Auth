import Foundation
import SwiftUI

final class GuestRouter: ObservableObject {
    static let shared = GuestRouter()
    
    @Published var path = [GuestRoute]()
    
    private var store: () = Store.getStore().subscribe {state in
        let isAuth = hasAuth(state)
        
        if (isAuth) {
            GuestRouter.shared.goToRoot()
        }
    }
    
    func goToWelcome() {
        path.append(.welcome)
    }

    func scanQrCode () {
        path.append(.qrCode)
    }
    
    func joingToTheGame(_ qrCode: String) {
        path.append(.roomJoingToTheGame(qrCode))
    }
    
    func back () {
        path.removeLast()
    }
    
    func goToRoot () {
        path.removeAll()
    }
}
