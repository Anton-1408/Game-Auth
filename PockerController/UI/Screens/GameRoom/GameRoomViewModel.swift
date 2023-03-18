//
//  GameRoomViewModel.swift
//  PockerController
//
//  Created by Anton Votinov on 10.03.2023.
//

import Foundation

final class GameRoomViewModel: ObservableObject {
    private let router: AuthRouter
    private let store = Store.getStore()
    
    init(router: AuthRouter) {
        self.router = router
    }
    
    public func signOut() {
        store.dispatch(Action.signOut)
    }
}
