//
//  Store.swift
//  PockerController
//
//  Created by Anton Votinov on 05.03.2023.
//

import Foundation

final class Store: ObservableObject {
    private var handlerSubscribe: HandlerSubscribe?
    
    @Published private(set) var state: AppState {
        didSet {
            handlerSubscribe?(state)
        }
    }
    
    private static var instance: Store?
    
    private init() {
        self.state = initialState
    }
    
    public static func getStore() -> Store {
        if (instance == nil) {
            instance = Store()
        }
            
        return instance!
    }
    
    public func dispatch(_ action: Action) {
        state = reducer(state: state, action: action)
    }
    
    public func subscribe(handler: @escaping HandlerSubscribe) {
        self.handlerSubscribe = handler
    }
}

let initialState = AppState.init(
    game: .init(isGameStarted: false, isGameOver: false, bigBlind: 0, smallBlind: 0, raiseAmount: 0, pot: 0, smallBlindPosition: 0, bigBlindPosition: 0, runninground: 0, finish: false, pause: false),
    user: nil,
    players: [],
    timer: 0,
    isCardOpened: false,
    dailyTalkController: .init(isAudio: true, isCamera: true),
    playersWaiting: [],
    playerFoldMaked: false,
    hasLeftBarRoom: false
)

typealias HandlerSubscribe = (_ state: AppState) -> Void
