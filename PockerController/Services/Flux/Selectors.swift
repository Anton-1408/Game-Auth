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

func hasUserInGame (_ state: AppState) -> Bool {
    let players = state.players;
    let userId = state.user?.id

    let currentPlayer = players.first(where: {player -> Bool in
        player.id == userId
    })

    return currentPlayer != nil
}

func getWaitingPlayerById (state: AppState, playerId: String?) -> WaitingPlayer? {
    let players = state.playersWaiting;

    let currentPlayer = players.first(where: {player -> Bool in
        player.id == playerId
    })

    return currentPlayer
}

func getInformationForRouting(_ state: AppState) -> DataForAuthInitialScreen {
    let playerInGame = getPlayerById(state: state, playerId: state.user?.id)
    let playerInWaitingRoon = getWaitingPlayerById(state: state, playerId: state.user?.id)
    let hasLeftBarRoom = state.hasLeftBarRoom
    
    if (playerInGame?.id != nil) {
        return .gameRoom
    }
    
    if (hasLeftBarRoom) {
        return .barRoom
    }
    
    if (playerInWaitingRoon != nil) {
        return .waitingRoom
    }
    
    return .barRoom
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

func getDailyController(_ state: AppState) -> DailyTalkController {
    return state.dailyTalkController
}

func getWaitingPlayers(_ state: AppState) -> [WaitingPlayer?] {
    var waitingPlayers = state.playersWaiting as [WaitingPlayer?]
    let maxPlayers = 8
    let differentSize = 8 - waitingPlayers.count
    
    for _ in 1...differentSize {
        waitingPlayers.append(nil)
    }
    
    return waitingPlayers
}
