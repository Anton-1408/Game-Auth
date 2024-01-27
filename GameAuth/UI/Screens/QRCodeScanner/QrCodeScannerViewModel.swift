import Foundation

final class QrCodeScannerViewModel: ObservableObject {
    private let router: GuestRouter;
    
    init(router: GuestRouter) {
        self.router = router
    }
    
    public func joingToTheGame(_ code: String) {
        router.joingToTheGame(code)
    }
}
