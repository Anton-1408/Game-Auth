import Foundation
import SwiftUI

struct RootStack: View {
    @ObservedObject private var store = Store.getStore()
    
    var body: some View {
        if (hasAuth(store.state)) {
            AuthStack()
        } else {
            GuestStack()
        }
    }
}
