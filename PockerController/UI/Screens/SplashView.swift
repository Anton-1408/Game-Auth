import Foundation
import SwiftUI

struct SplashView: View {
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            if (isActive) {
                RootStack()
            } else {
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundColor(GrayScale.Black)

                Image("SplashScreenIcons")
                    .frame(width: 90, height: 97)
            }
        }
        .background(BackgroundClearView())
        .preferredColorScheme(ColorScheme.dark)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                  withAnimation {
                      self.isActive = true
                  }
            }
        }
    }
}
