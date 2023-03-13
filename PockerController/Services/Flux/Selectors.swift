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

func getPlayerById (state: AppState, playerId: String?) -> PlayersOfGame? {
    let players = state.players;
    
    let currentPlayer = players.first(where: {player -> Bool in
        player.id == playerId
    })
    
    return currentPlayer
}

func getInformationForRouting(_ state: AppState) ->  DataForAuthInitialScreen {
    let currentPlayer = getPlayerById(state: state, playerId: state.user?.id)
    let isGameFinished = state.game.finish
    let isGameOver = state.game.isGameOver
    
    return DataForAuthInitialScreen.init(isGameFinished: isGameFinished, isGameOver: isGameOver, isPlayerInGame: currentPlayer?.id != nil)
}

func getDataForSocket(_ state: AppState) -> [String: String?] {
    return [
        "gameId": state.game.id,
        "userId": state.user?.id
    ]
}
