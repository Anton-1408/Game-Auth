//
//  GameRoomView.swift
//  PockerController
//
//  Created by Anton Votinov on 10.03.2023.
//

import SwiftUI

struct GameRoomView: View {
    @ObservedObject var viewModel: GameRoomViewModel
    @ObservedObject var store = Store.getStore()

    var body: some View {
        let routerInfo = getInformationForRouting(store.state)
        
        VStack {
            Text("Game room")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(GrayScale.Black)
        .onChange(of: routerInfo){router in
            if (router == .waitingRoom) {
                viewModel.goToTheWaitingRoom()
            }
            
            if (router == .barRoom) {
                viewModel.goToTheBarRoom()
            }
        }
    }
}

struct GameRoomView_Previews: PreviewProvider {
    static var previews: some View {
        GameRoomAssembly().build()
    }
}
