//
//  RoomJoingToTheGameAssambly.swift
//  PockerController
//
//  Created by Anton Votinov on 24.02.2023.
//

import Foundation

final class RoomJoingToTheGameAssembly {
    func build(for qrCodeData: String) -> RoomJoingToTheGameView {
        let router = GuestRouter.shared
        let viewModel = RoomJoingToTheGameViewModel(qrCodeData: qrCodeData, router: router)
        
        return RoomJoingToTheGameView(viewModel: viewModel)
    }
}
