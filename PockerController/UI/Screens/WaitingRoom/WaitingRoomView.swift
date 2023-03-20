//
//  WaitingRoomView.swift
//  PockerController
//
//  Created by Anton Votinov on 10.03.2023.
//

import SwiftUI

struct WaitingRoomView: View {
    @ObservedObject var viewModel: WaitingRoomViewModel;
    @ObservedObject var store = Store.getStore()

    var body: some View {
        VStack {
            Header(handlerSignOut: {
                store.dispatch(.signOut)
            })
            .padding(.top, 16)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(GrayScale.Black)
    }
    
}

struct WaitingRoomView_Previews: PreviewProvider {
    static var previews: some View {
        WaitingRoomAssembly().build()
    }
}
