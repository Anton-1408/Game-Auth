//
//  Selectors.swift
//  PockerController
//
//  Created by Anton Votinov on 08.03.2023.
//

import Foundation


func hasAuth(_ state: AppState) -> Bool {
    return state.authToken != nil
}
