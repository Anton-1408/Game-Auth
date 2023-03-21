//
//  WaitingRoomView.swift
//  PockerController
//
//  Created by Anton Votinov on 10.03.2023.
//

import SwiftUI
import WrappingHStackLayout

struct WaitingRoomView: View {
    @ObservedObject var viewModel: WaitingRoomViewModel;
    @ObservedObject var store = Store.getStore()

    var body: some View {
        let waitingPlayers = getWaitingPlayers(store.state)
        let canGoToGamePanel = hasUserInGame(store.state)
        
        VStack {
            Header(handlerSignOut: {
                store.dispatch(.signOut)
            })
            .padding(.top, 16)
            
            ScrollView {
                WrappingHStack(alignment: .leading) {
                    ForEach(waitingPlayers, id: \.?.id) { waitingPlayer in
                            ContainerUser(
                                handlerProfileClick: {},
                                name: waitingPlayer?.name,
                                avatar: waitingPlayer?.avatar
                            )
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(GrayScale.Black)
        .onChange(of: canGoToGamePanel) { isNavigate in
            if (isNavigate) {
                viewModel.goToGamePanel()
            }
        }
    }
    
}

struct WaitingRoomView_Previews: PreviewProvider {
    static var previews: some View {
        WaitingRoomAssembly().build()
    }
}
