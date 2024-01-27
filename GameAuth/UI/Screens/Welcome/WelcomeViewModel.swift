import Foundation

final class WelcomeViewModel: ObservableObject {
    private let router: GuestRouter;
    
    init(router: GuestRouter) {
        self.router = router
    }
    
    func goToQRCodeScanner() {
        router.scanQrCode()
    }
}
