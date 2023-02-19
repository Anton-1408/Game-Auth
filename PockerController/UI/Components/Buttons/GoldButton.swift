import Foundation
import SwiftUI

struct GoldButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 344, height: 50)
            .foregroundColor(GrayScale.White)
            .font(Typography.Body_1_Hardware_Regular_16px_20)
            .background(Primary.Default)
            .textCase(.uppercase)
            .cornerRadius(6)
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
