import Foundation
import SwiftUI

final class GuestRouter: ObservableObject {
    static let shared = GuestRouter()
    
    @Published var path = [GuestRoute]()
    
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
