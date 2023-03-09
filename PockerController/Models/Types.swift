//
//  LastAction.swift
//  PockerController
//
//  Created by Anton Votinov on 09.03.2023.
//

import Foundation

struct LastAction {
    var userId: String
    var action: String
}

struct ActionOneToOneCall {
    var isMyRequest: Bool
    var informationCall: InformationCall
}
