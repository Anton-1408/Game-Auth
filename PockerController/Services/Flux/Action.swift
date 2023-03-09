//
//  Actions.swift
//  PockerController
//
//  Created by Anton Votinov on 05.03.2023.
//

import Foundation


enum Action {
    case setAuthToken(_ accessToken: Auth)
    case signOut
    case setUser(_ user: User)
    case setTimer(_ timer: Int)
    case resetTimer
    case setGameLoaded(_ isLoaded: Bool)
    case setIsAudio(_ isAudio: Bool)
    case setIsCamera(_ isCamera: Bool)
    case setIsCardOpened(_ IsCardOpened: Bool)
    case setFoldMaked(_ isFoldMaked: Bool)
    case setWaitingPlayers(_ playersOfWaiting: [PlayerOfWaiting])
    case setPlayers(_ players: [PlayersOfGame])
    case setIsGamePause(_ IsGamePause: Bool)
    case setIsGameOver(_ IsGameOver: Bool)
    case setLastAction(_ lastAction: LastAction)
    case setProcessGame(_ game: GameData)
    case leaveCall
    case aceptCall(_ roomId: String)
    case skipOneToOneRequest
    case setOneToOneRequestBy(_ oneToOneCall: ActionOneToOneCall)
}
