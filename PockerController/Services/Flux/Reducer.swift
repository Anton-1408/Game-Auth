//
//  Reducers.swift
//  PockerController
//
//  Created by Anton Votinov on 06.03.2023.
//

import Foundation

func reducer(state: AppState, action: Action) -> AppState {
    var state = state
    
    switch action {
        case .setAuthToken(let accessToken):
            state.authToken = accessToken
        case .signOut:
            state = initialState
        case .setUser(let user):
            state.user = user
        case .setTimer(let timer):
            state.timer = timer
        case .resetTimer:
            state.timer = 0
        case .setGameLoaded(let isGameLoaded):
            state.isGameLoaded = isGameLoaded
        case .setIsAudio(let isAudio):
            state.dailyTalkController.isAudio = isAudio
        case .setIsCamera(let isCamera):
            state.dailyTalkController.isCamera = isCamera
        case .setIsCardOpened(let isCardOpened):
            state.isCardOpened = isCardOpened
        case .setFoldMaked(let isFoldMaked):
            state.playerFoldMaked = isFoldMaked
        case .setWaitingPlayers(let playersWaiting):
            state.playersWaiting = playersWaiting
        case .setPlayers(let players):
            state.players = players
        case .setIsGamePause(let isGamePause):
            state.game.pause = isGamePause
        case .setIsGameOver(let IsGameOver):
            state.game.isGameOver = IsGameOver
        case .setLastAction(let lastAction):
            state.game.lastAction = lastAction
    case .setProcessGame(let game):
        state.game = .init(
            id: game.id,
            isGameStarted: game.gamestart,
            lastAction: state.game.lastAction ?? nil,
            isGameOver: state.game.isGameOver,
            bigBlind: game.bigBlind,
            smallBlind: game.smallBlind,
            raiseAmount: game.raiseAmount,
            pot: game.pot,
            smallBlindPosition: game.smallBlindPosition,
            bigBlindPosition: game.bigBlindPosition,
            runninground: game.runninground,
            finish: game.finish,
            pause: game.pause
        )
    case .leaveCall:
        state.oneToOneCall.isLeaved = true
    case .aceptCall(let roomId):
        state.oneToOneCall.roomId = roomId
    case .skipOneToOneRequest:
        state.oneToOneCall = initialState.oneToOneCall
    case .setOneToOneRequestBy(let oneToOneCall):
        state.oneToOneCall.hasCallIncoming = oneToOneCall.isMyRequest
        state.oneToOneCall.informationCall = oneToOneCall.informationCall
    }
    
    return state
}
