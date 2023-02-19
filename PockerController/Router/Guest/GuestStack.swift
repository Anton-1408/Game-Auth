import Foundation
import SwiftUI

struct GuestStack: View {
    @ObservedObject var router = GuestRouter.shared;

    var body: some View {
        NavigationStack(path: $router.path) {
            WelcomeView()
                .navigationDestination(for: GuestRoute.self) { route in
                    switch route {
                        case GuestRoute.welcome:
                            WelcomeView()
                        case GuestRoute.qrCode:
                            QrCodeScannerView()
                    }
                }
        }
    }
}
