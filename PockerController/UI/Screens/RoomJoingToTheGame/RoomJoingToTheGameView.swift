import Foundation
import SwiftUI

struct RoomJoingToTheGameView: View {
    @ObservedObject var viewModel: RoomJoingToTheGameViewModel;
    @StateObject var qrCodeScannerWorker = QRCodeScannerWorker();
    @State var isPortrait = UIDevice.current.orientation.isPortrait
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            VStack {
                if qrCodeScannerWorker.isLoading {
                    Spinner(typeSpinner: .LineSpinner)
                    Text("Synchronization...")
                        .font(Typography.Body_1_Gilroy_Medium_16px_20)
                        .foregroundColor(GrayScale.White)
                        .padding(.top, 16)

                } else {
                    Image("Check")
                    Text("The application was successfully paired")
                        .font(Typography.Body_1_Gilroy_Medium_16px_20)
                        .foregroundColor(GrayScale.White)
                        .padding(.top, 16)
                        .multilineTextAlignment(.center)
                        .lineLimit(20)
                        .lineSpacing(8)
                        .frame(maxWidth: isPortrait ? 230 : .none)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(GrayScale.Black)
            
            Back(handlePress: {
                viewModel.goToWelcomeScreen()
            })
        }
        .task {
            await self.qrCodeScannerWorker.signIn(
               token: self.viewModel.qrCodeData,
               deviceInformation: .init(
                   deviceInformation: .init(
                      deviceName: UIDevice.current.name,
                      deviceOS: "IOS",
                      deviceModel: UIDevice.current.model,
                      deviceVersion: UIDevice.current.systemVersion
                   )
               )
            )
        }
        .onRotate { isPortrait in
            self.isPortrait = isPortrait
        }
    }
}
