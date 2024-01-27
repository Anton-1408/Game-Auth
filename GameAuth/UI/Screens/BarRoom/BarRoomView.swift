//
//  BarRoomView.swift
//  PockerController
//
//  Created by Anton Votinov on 10.03.2023.
//

import SwiftUI

struct BarRoomView: View {
    @ObservedObject var viewModel: BarRoomViewModel;
    
    var body: some View {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene;
        
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            VStack {
                Text("Join the game!")
                    .font(Typography.Title_2_Hardware_Condensed_36px_46)
                    .foregroundColor(GrayScale.White)
                    .padding(.bottom, 12)
                Text("To use CPN Remote Controller, go to the game by clicking on the link from the original invite")
                    .font(Typography.Body_1_Gilroy_Regular_16px_20)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 345)
                    .foregroundColor(GrayScale.White)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(GrayScale.Black)
            
            IconButton(handlePress: viewModel.signOut, backgroundColor: Secondary.Dark, icon: "Exit")
                .padding([.top], 16)
        }
        .onAppear {
            windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: .landscape))
        }
        .onRotate { isPortrait in
            if( isPortrait) {
                windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: .landscape))
            }
        }
    }
}

struct BarRoomView_Previews: PreviewProvider {
    static var previews: some View {
        BarRoomAssembly().build()
    }
}
