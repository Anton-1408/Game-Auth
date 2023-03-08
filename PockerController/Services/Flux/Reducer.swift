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
            state.authToken = nil
            state.user = nil
        case .setUser(let user):
            state.user = user
    }
    
    return state
}
