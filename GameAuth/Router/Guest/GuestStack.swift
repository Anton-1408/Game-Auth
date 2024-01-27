import Foundation
import SwiftUI

struct GuestStack: View {
    @ObservedObject var router = GuestRouter.shared;

    var body: some View {
        NavigationStack(path: $router.path) {
            WelcomeAssembly().build()
                .navigationDestination(for: GuestRoute.self) { route in
                    switch route {
                        case .welcome:
                                WelcomeAssembly().build()
                        case .qrCode:
                                QRCodeScannerAssembly().build()
                                    .navigationBarHidden(true)
                                    .ignoresSafeArea(.all)
                        case .roomJoingToTheGame(let qrCodeData):
                                RoomJoingToTheGameAssembly().build(for: qrCodeData)
                                   .navigationBarHidden(true)
                    }
            }
        }
    }
}
