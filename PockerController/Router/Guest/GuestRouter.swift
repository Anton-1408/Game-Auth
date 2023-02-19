import Foundation
import SwiftUI

final class GuestRouter: ObservableObject {
    static let shared = GuestRouter()
    
    @Published var path = [GuestRoute]()
    
    func goToWelcome() {
        path.append(GuestRoute.welcome)
    }

    func scanQrCode () {
        path.append(GuestRoute.qrCode)
    }
    
    func back () {
        path.removeLast()
    }
    
    func goToRoot () {
        path.removeAll()
    }
}
