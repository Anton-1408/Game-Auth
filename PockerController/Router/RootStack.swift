import Foundation
import SwiftUI

struct RootStack: View {
    private let isAuth = false
    
    var body: some View {
        if (isAuth) {
            AuthStack()
        } else {
            GuestStack()
        }
    }
}
