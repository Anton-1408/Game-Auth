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
        let room = getInformationForRouting(store.state)
        
        switch room {
            case .barRoom:
                BarRoomAssembly().build()
            case .waitingRoom:
                WaitingRoomAssembly().build()
            case .gameRoom:
                GameRoomAssembly().build()
            default:
                Spinner(typeSpinner: .WhiteSpinner)
        }
    }
}
