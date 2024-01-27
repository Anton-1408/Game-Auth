//
//  UserInfoWorker.swift
//  PockerController
//
//  Created by Anton Votinov on 25.03.2023.
//

import Foundation

final class PlayerInfoWorker: ObservableObject {
    @Published var loading: Bool = true
    @Published var error: Error? = nil
    @Published var hasError: Bool = false
    @Published var data: PlayerInfo? = nil
    
    private let api = Api.getInstance()
    
    func getPlayerProfile(playerId: String) async {
        self.loading = true
        self.hasError = false
        self.error = nil
        self.data = nil

        await self.api.getInformationForPlayers(
            playerId: playerId,
            handleError: {error in
                self.loading = false
                self.hasError = true
                self.error = error
            },
            handleSuccess: { result in
                self.loading = false
                self.hasError = true
                self.data = result
            }
        )
    }
}
