//
//  InitialAuthView.swift
//  PockerController
//
//  Created by Anton Votinov on 11.03.2023.
//

import Foundation
import SwiftUI

struct InitialAuthView: View {
    @StateObject var store = Store.getStore()

    var body: some View {
        let data = getInformationForRouting(store.state)

        if (data.isPlayerInGame) {
            GameRoomAssembly().build()
        } else {
            if (data.hasLeftBarRoom) {
                BarRoomAssembly().build()
            } else {
                WaitingRoomAssembly().build()
            }
        }
    }
}
