//
//  WebSocketManager.swift
//  PockerController
//
//  Created by Anton Votinov on 11.03.2023.
//

import Foundation
import SocketIO

class WebSocketManager {
    private static var instance: WebSocketManager?

    private let manager = SocketManager(socketURL: URL(string: websocketKey!)!, config: [.log(true), .compress])
    let socket: SocketIOClient

    private init () {
        socket = manager.socket(forNamespace: "/")
    }
    
    public static func getInstance() -> WebSocketManager {
        if (instance == nil) {
            instance = WebSocketManager()
        }
        
        return instance!
    }
    
    public func connect() {
        socket.connect()
    }
    
    public func disconnect() {
        socket.disconnect()
    }
    
}
