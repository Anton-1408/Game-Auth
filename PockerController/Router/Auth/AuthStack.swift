import Foundation
import SwiftUI

struct AuthStack: View {
    @ObservedObject var router = AuthRouter.shared
    @StateObject var store = Store.getStore()
    @StateObject var websocketWorker = WebSocketsSubscriptionWorker();

    var body: some View {
        ZStack {
          if (!websocketWorker.isGameLoaded) {
              Spinner(typeSpinner: .WhiteSpinner)
          } else {
             NavigationStack(path: $router.path) {
               InitialAuthView()
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
             }.environmentObject(store)
          }
        }
        .task {
            websocketWorker.subscribe()
        }
    }
}
