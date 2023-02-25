//
//  RoomJoingToTheGameViewModel.swift
//  PockerController
//
//  Created by Anton Votinov on 24.02.2023.
//

import Foundation

final class RoomJoingToTheGameViewModel: ObservableObject {
    @Published var qrCodeData: String;
    private let router: GuestRouter
    
    init(qrCodeData: String, router: GuestRouter) {
        self.qrCodeData = qrCodeData
        self.router = router
    }
    
    public func goToWelcomeScreen() {
        router.goToRoot()
    }
}
