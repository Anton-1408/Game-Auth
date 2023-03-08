//
//  Store.swift
//  PockerController
//
//  Created by Anton Votinov on 05.03.2023.
//

import Foundation

final class Store: ObservableObject {
    @Published private(set) var state: AppState
    
    private static var instance: Store?
    
    private init() {
        self.state = .init(
            game: .init(isGameStarted: false, isGameOver: false, bigBlind: 0, smallBlind: 0, raiseAmount: 0, pot: 0, smallBlindPosition: 0, bigBlindPosition: 0, runninground: 0, finish: false, pause: false),
            user: nil,
            players: [],
            timer: 0,
            isCardOpened: false,
            dailyTalkController: .init(isAudio: true, isVideo: true),
            isGameLoaded: false,
            playersWaiting: [],
            oneToOneCall: .init(informationCall: nil, isAccepted: false, hasCallIncoming: false, roomId: nil, isLeaved: false)
        )
    }
    
    public static func getStore() -> Store {
        if (instance == nil) {
            instance = Store()
        }
            
        return instance!
    }
    
    public func dispath(_ action: Action) {
        state = reducer(state: state, action: action)
    }
}
