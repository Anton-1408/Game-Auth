import Foundation
import SwiftUI

struct AuthStack: View {
    @ObservedObject var router = AuthRouter.shared

    var body: some View {
        NavigationStack(path: $router.path) {
            WaitingRoomView()
                .navigationDestination(for: AuthRoute.self) { route in
                    switch route {
                        case AuthRoute.gameRoom:
                              GameRoomView()
                        case AuthRoute.barRoom:
                            BarRoomView()
                        case AuthRoute.waitingRoom:
                            WaitingRoomView()
                    }
                }
        }
    }
}
