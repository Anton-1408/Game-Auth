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
    var players: [PlayersOfGame]
    var timer: Int
    var isCardOpened: Bool
    var dailyTalkController: DailyTalkController
    var isGameLoaded: Bool
    var playersWaiting: [PlayerOfWaiting]
    var oneToOneCall: OneToOneCall
    var playerFoldMaked: Bool
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

struct PlayersOfGame: Identifiable {
    var action: String?
    var actionType: String?
    var avatar: String
    var cards: Array<String>
    var email: String
    var id: String
    var meetingToken: String
    var name: String
    var playing: Bool
    var position: Int
    var tablePosition: Int
    var tentativeAction: String?
    var timebank: Int
    var wallet: Int
    var fold: Bool
    var prevPot: Int
    var pot: Int
}

struct PlayerOfWaiting: Identifiable {
    var action: String?
    var actionType: String?
    var avatar: String
    var cards: Array<String>
    var email: String
    var id: String
    var meetingToken: String
    var name: String
    var playing: Bool
    var position: Int
    var tablePosition: Int
    var tentativeAction: String?
    var timebank: Int
    var wallet: Int
    var fold: Bool
    var prevPot: Int
    var pot: Int
}
