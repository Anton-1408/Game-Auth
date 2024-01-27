//
//  BarRoomAssembly.swift
//  PockerController
//
//  Created by Anton Votinov on 10.03.2023.
//

import Foundation


final class BarRoomAssembly {
    public func build() -> BarRoomView {
        let router = AuthRouter.shared
        let viewModel = BarRoomViewModel(router: router)
        
        return BarRoomView(viewModel: viewModel)
    }
}
