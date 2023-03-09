//
//  ResponseData.swift
//  PockerController
//
//  Created by Anton Votinov on 25.02.2023.
//

import Foundation

struct Response: Decodable {
    var authToken: TokenData
    var game: GameData
    var user: UserData
}

struct TokenData: Decodable {
    var access: Access
    var refresh: Refresh

    struct Access: Decodable {
        var expires: String
        var token: String
    }
    
    struct Refresh: Decodable {
        var expires: String
        var token: String
    }
}

struct GameData: Identifiable, Decodable {
    var id: String
    var allowWatcher: Bool
    var autoNextHand: Bool
    var autoTimer: Bool
    var bigBlind: Int
    var buyin: Int
    var createdAt: String
    var dealerPosition: Int?
    var emergencyTimer: Int
    var finish: Bool
    var flopround: Array<Player>
    var gameName: String
    var gamestart: Bool
    var hostId: String?
    var icreasingBlindMinutes: Int
    var invNamePlayers: Array<InvEmails>?
    var isCircleCompleted: Bool
    var isGameRunning: Bool
    var isReset: Bool
    var isShowdown: Bool
    var lastAction: String?
    var maxchips: Int
    var meetingToken: String
    var minchips: Int
    var pause: Bool
    var players: Array<Player>
    var pot: Int
    var preflopround: Array<Player>
    var raiseAmount: Int
    var raisePlayerPosition: Int?
    var riverround: Array<Player>
    var runninground: Int
    var showdown: Array<Player>
    var smallBlind: Int
    var smallBlindPosition: Int?
    var timer: Int
    var turnround: Array<Player>
    var updatedAt: String
    var usedCards: Array<String>
    var waitingPlayers: Array<Player>
    var bigBlindPosition: Int?
}

struct UserData: Decodable, Identifiable {
    var aboutMe: String
    var avatar: String
    var companyName: String
    var createdAt: String
    var email: String
    var firstName: String
    var id: String
    var instagram: String
    var isActive: Bool
    var isEmailVerified: Bool
    var isLinkPublic: Bool
    var lastName: String
    var name: String
    var phoneNumber: String
    var role: String
    var title: String
    var twitter: String
    var updatedAt: String
}

struct Player: Decodable, Identifiable {
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
    var timebank: Int?
    var wallet: Int
    var fold: Bool?
    var prevPot: Int?
    var pot: Int?
}

struct Error: Decodable {
    var title: String
    var message: String
}

struct InvEmails: Decodable {
    var avatar: String
    var email: String
    var name: String
    var userId: String
}
