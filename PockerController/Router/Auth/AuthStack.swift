import Foundation
import SwiftUI

struct AuthStack: View {
    @ObservedObject var router = AuthRouter.shared

    var body: some View {
        NavigationStack(path: $router.path) {
            WaitingRoomAssembly().build()
                .navigationDestination(for: AuthRoute.self) { route in
                    switch route {
                        case AuthRoute.gameRoom:
                            GameRoomAssembly().build()
                                .navigationBarHidden(true)
                        case AuthRoute.barRoom:
                            BarRoomAssembly().build()
                                .navigationBarHidden(true)
                        case AuthRoute.waitingRoom:
                            WaitingRoomAssembly().build()
                                .navigationBarHidden(true)
                    }
                }
        }
    }
}
