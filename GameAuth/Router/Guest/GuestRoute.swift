import Foundation

enum GuestRoute: Hashable {
    case welcome
    case qrCode
    case roomJoingToTheGame(_ qrCode: String)
}
