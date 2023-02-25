import Foundation
import SwiftUI

struct RoomJoingToTheGameView: View {
    @ObservedObject var viewModel: RoomJoingToTheGameViewModel;
    
    @State private var isLoading = false
    @State private var isPortrait = UIDevice.current.orientation.isPortrait

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            VStack {
                if isLoading {
                    Spinner()
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
        .onRotate {isPortrait in
            self.isPortrait = isPortrait
        }
    }
}
