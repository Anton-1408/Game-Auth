//
//  AppState.swift
//  PockerController
//
//  Created by Anton Votinov on 05.03.2023.
//

import Foundation

struct AppState {
    var authToken: Auth?
    var game: Game
    var user: User?
    var players: [Player]
    var timer: Int
    var isCardOpened: Bool
    var dailyTalkController: DailyTalkController
    var playersWaiting: [WaitingPlayer]
    var playerFoldMaked: Bool
    var hasLeftBarRoom: Bool
}

struct Auth {
    var expires: String
    var token: String
}

struct Game: Identifiable {
    var id: String?
    var isGameStarted: Bool
    var lastAction: LastAction?
    var isGameOver: Bool
    var bigBlind: Int
    var smallBlind: Int
    var raiseAmount: Int
    var pot: Int
    var smallBlindPosition: Int?
    var bigBlindPosition: Int?
    var runninground: Int
    var finish: Bool
    var pause: Bool
}

struct User: Identifiable {
    var id: String
    var name: String
}

struct DailyTalkController {
    var isAudio: Bool
    var isCamera: Bool
}

struct InformationCall {
    var gameId: String
    var requestedBy: String
    var requestedByName: String
    var requestedTo: String
    var requestedToName: String
}

struct OneToOneCall {
    var informationCall: InformationCall?
    var isAccepted: Bool
    var hasCallIncoming: Bool
    var roomId: String?
    var isLeaved: Bool
}

