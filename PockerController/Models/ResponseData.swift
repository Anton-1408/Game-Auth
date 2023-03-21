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
    var waitingPlayers: Array<WaitingPlayer>
    var barroomPlayers: Array<BarRoomPlayer>
    var bigBlindPosition: Int?
    
    func getPlayersForRound(_ runninground: Int) -> [Player]  {
        switch runninground {
            case 0:
                return self.players;
            case 1:
                return self.preflopround
            case 2:
                return self.flopround
            case 3:
                return self.turnround
            case 4:
                return self.riverround
            case 5:
                return self.showdown
            default:
                return self.players
        }
    }
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

struct WaitingPlayer: Decodable, Identifiable {
    var id: String
    var firstName: String
    var lastName: String
    var name: String
    var instagram: String
    var email: String
    var aboutMe: String
    var avatar: String
    var companyName: String
    var createdAt: String
    var meetingToken: String?
    var role: String
    var title: String
    var twitter: String
}

struct BarRoomPlayer: Decodable, Identifiable {
    var id: String
    var instagram: String
    var gameMeetingToken: String
    var firstName: String
    var email: String
    var companyName: String
    var avatar: String
    var aboutMe: String
    var createdAt: String
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

struct BarRoomLeft: Decodable {
    var userId: String
    var game: GameData
}

struct CardCheck: Decodable {
    var userId: String
    var gameId: String
}

struct Timer: Decodable {
    var id: String
    var maxtimer: Int
    var playerchance: Int
    var runninground: Int
    var timerPlayer: Int
}

struct ActionPerformed: Decodable {
    var id: String
    var action: String
}

struct PlayerCameraChange: Decodable {
  var gameId: String
  var userId: String
  var isVideo: Bool
}

struct PlayerMicrophoneChange: Decodable {
  var gameId: String
  var userId: String
  var isAudio: Bool
}
