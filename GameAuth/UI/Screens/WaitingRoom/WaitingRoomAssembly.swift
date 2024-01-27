//
//  WaitingRoomAssambly.swift
//  PockerController
//
//  Created by Anton Votinov on 10.03.2023.
//

import Foundation

final class WaitingRoomAssembly {
    func build() -> WaitingRoomView {
        let router = AuthRouter.shared
        let viewModel = WaitingRoomViewModel(router: router)
        
        return WaitingRoomView(viewModel: viewModel)
    }
}
