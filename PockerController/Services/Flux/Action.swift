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
}
