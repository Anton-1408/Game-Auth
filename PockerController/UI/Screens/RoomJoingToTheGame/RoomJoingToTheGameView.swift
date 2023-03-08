import Foundation
import SwiftUI

struct RoomJoingToTheGameView: View {
    @ObservedObject var viewModel: RoomJoingToTheGameViewModel;
    
    @EnvironmentObject var store: Store
    
    @State private var isLoading = true
    @State private var isPortrait = UIDevice.current.orientation.isPortrait

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            VStack {
                if isLoading {
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
           await viewModel.sendQrCode(
            deviceModel: UIDevice.current.model,
            deviceVersion: UIDevice.current.systemVersion,
            deviceName: UIDevice.current.name,
            handleError: {error in
                print("Error", error)
            },
            handleSuccess: {result in
                let authToken = result.authToken.access
                let userId = result.user.id
                let userName = result.user.name
                
                isLoading = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    store.dispath(.setAuthToken(
                        .init(
                            expires: authToken.expires,
                            token: authToken.token
                        )
                    ))
                    store.dispath(.setUser(
                        .init(
                            id: userId,
                            name: userName
                        )
                    ))
                }
            }
          )
        }
        .onRotate { isPortrait in
            self.isPortrait = isPortrait
        }
    }
}
