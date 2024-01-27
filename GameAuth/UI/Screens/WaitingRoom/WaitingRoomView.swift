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
    
    @State private var isPlayerProfileVisible = false
    @State private var playerId: String? = nil

    var body: some View {
        let waitingPlayers = getWaitingPlayers(store.state)
        let routerInfo = getInformationForRouting(store.state)
        
        ZStack {
            VStack {
                Header(handlerSignOut: {
                    store.dispatch(.signOut)
                })
                .padding(.top, 16)
                
                ScrollView {
                    WrappingHStack(alignment: .leading) {
                        ForEach(waitingPlayers, id: \.?.id) { waitingPlayer in
                            ContainerUser(
                                handlerProfileClick: {
                                    withAnimation {
                                        playerId = waitingPlayer?.id
                                        isPlayerProfileVisible.toggle()
                                    }
                                },
                                name: waitingPlayer?.name,
                                avatar: waitingPlayer?.avatar
                            )
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(GrayScale.Black)
            .onChange(of: routerInfo) { router in
                if (router == .gameRoom) {
                    viewModel.goToGamePanel()
                }
            }
            
            if (isPlayerProfileVisible) {
                ProfileModal(
                    handlerClose: {
                        isPlayerProfileVisible.toggle()
                    },
                    playerId: playerId
                )
            }
        }
    }
    
}

struct WaitingRoomView_Previews: PreviewProvider {
    static var previews: some View {
        WaitingRoomAssembly().build()
    }
}
