//
//  Constants.swift
//  PockerController
//
//  Created by Anton Votinov on 26.02.2023.
//

import Foundation
import UIKit

let apiKey = Bundle.main.object(forInfoDictionaryKey: "APP_API_BASE_URL") as? String
let websocketKey = Bundle.main.object(forInfoDictionaryKey: "WEBSOCKET_BASE_URL") as? String

let deviceHeight = UIScreen.main.bounds.height
let deviceWidth =  UIScreen.main.bounds.width

let bigSide = deviceHeight > deviceWidth ? deviceHeight : deviceWidth
