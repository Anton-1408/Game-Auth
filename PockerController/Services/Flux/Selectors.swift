//
//  Selectors.swift
//  PockerController
//
//  Created by Anton Votinov on 08.03.2023.
//

import Foundation


func hasAuth(_ state: AppState) -> Bool {
    return state.authToken != nil
}

func getPlayerById (state: AppState, playerId: String?) -> Player? {
    let players = state.players;

    let currentPlayer = players.first(where: {player -> Bool in
        player.id == playerId
    })

    return currentPlayer
}

func getInformationForRouting(_ state: AppState) -> DataForAuthInitialScreen {
    let currentPlayer = getPlayerById(state: state, playerId: state.user?.id)
    let hasLeftBarRoom = state.hasLeftBarRoom

    return DataForAuthInitialScreen.init(hasLeftBarRoom: hasLeftBarRoom,  isPlayerInGame: currentPlayer?.id != nil)
}

func getDataForSocket(_ state: AppState) -> [String: String?] {
    return [
        "gameId": state.game.id,
        "userId": state.user?.id
    ]
}

func getCurrentUserId(_ state: AppState) -> String? {
    return state.user?.id
}
