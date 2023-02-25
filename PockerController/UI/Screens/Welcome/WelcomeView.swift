import Foundation
import SwiftUI

struct WelcomeView: View {
    @ObservedObject var viewModel: WelcomeViewModel;
    
    var body: some View {
        VStack(alignment: .center) {
            Image("Welcome")
                .frame(width: 77, height: 46)
            Text("Welcome to \n Cloud Poker night")
                .font(Typography.Title_2_Hardware_Condensed_36px_46)
                .foregroundColor(GrayScale.White)
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)
                .lineSpacing(8)
            Text("To start playing, you need to scan the QR \n code on the web version of Cloud Poker Night")
                .font(Typography.Body_1_Gilroy_Regular_16px_20)
                .foregroundColor(GrayScale.White)
                .multilineTextAlignment(.center)
                .lineLimit(20)
                .lineSpacing(8)
            Button("start scanning") {
                viewModel.goToQRCodeScanner()
            }
            .buttonStyle(GoldButton())
            .padding(.top, 32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 16)
        .background(GrayScale.Black)
    }
}
