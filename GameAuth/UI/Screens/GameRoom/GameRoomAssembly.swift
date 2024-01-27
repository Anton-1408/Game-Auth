//
//  GameRoomAssembly.swift
//  PockerController
//
//  Created by Anton Votinov on 10.03.2023.
//

import Foundation

final class GameRoomAssembly {
    func build() -> GameRoomView {
        let router = AuthRouter.shared
        let viewModel = GameRoomViewModel(router: router)
        
        return GameRoomView(viewModel: viewModel)
    }
}
